local wezterm = require("wezterm")
local session_manager = {}
local os = wezterm.target_triple

--- Displays a notification in WezTerm.
-- @param message string: The notification message to be displayed.
local function display_notification(message)
  wezterm.log_info(message)
  -- Additional code to display a GUI notification can be added here if needed
end

--- Retrieves the current workspace data from the active window.
-- @return table or nil: The workspace data table or nil if no active window is found.
local function retrieve_workspace_data(window)
  local workspace_name = window:active_workspace()
  local workspace_data = {
    name = workspace_name,
    tabs = {}
  }

  -- Iterate over tabs in the current window
  for _, tab in ipairs(window:mux_window():tabs()) do
    local tab_data = {
      tab_id = tostring(tab:tab_id()),
      panes = {}
    }

    -- Iterate over panes in the current tab
    for _, pane_info in ipairs(tab:panes_with_info()) do
      -- Collect pane details, including layout and process information
      table.insert(tab_data.panes, {
        pane_id = tostring(pane_info.pane:pane_id()),
        index = pane_info.index,
        is_active = pane_info.is_active,
        is_zoomed = pane_info.is_zoomed,
        left = pane_info.left,
        top = pane_info.top,
        width = pane_info.width,
        height = pane_info.height,
        pixel_width = pane_info.pixel_width,
        pixel_height = pane_info.pixel_height,
        cwd = tostring(pane_info.pane:get_current_working_dir()),
        tty = tostring(pane_info.pane:get_foreground_process_name())
      })
    end

    table.insert(workspace_data.tabs, tab_data)
  end

  return workspace_data
end

--- Saves data to a JSON file.
-- @param data table: The workspace data to be saved.
-- @param file_path string: The file path where the JSON file will be saved.
-- @return boolean: true if saving was successful, false otherwise.
local function save_to_json_file(data, file_path)
  if not data then
    wezterm.log_info("No workspace data to log.")
    return false
  end

  local file = io.open(file_path, "w")
  if file then
    file:write(wezterm.json_encode(data))
    file:close()
    return true
  else
    return false
  end
end

--- Recreates the workspace based on the provided data.
-- @param workspace_data table: The data structure containing the saved workspace state.
local function recreate_workspace(window, workspace_data)
  local function extract_path_from_dir(working_directory)
    if os == "x86_64-pc-windows-msvc" then
      -- On Windows, transform 'file:///C:/path/to/dir' to 'C:/path/to/dir'
      return working_directory:gsub("file:///", "")
    elseif os == "x86_64-unknown-linux-gnu" then
      -- On Linux, transform 'file://{computer-name}/home/{user}/path/to/dir' to '/home/{user}/path/to/dir'
      return working_directory:gsub("^.*(/home/)", "/home/")
    else
      return working_directory:gsub("^.*(/Users/)", "/Users/")
    end
  end

  if not workspace_data or not workspace_data.tabs then
    wezterm.log_info("Invalid or empty workspace data provided.")
    return
  end

  local tabs = window:mux_window():tabs()

  if #tabs ~= 1 or #tabs[1]:panes() ~= 1 then
    wezterm.log_info(
      "Restoration can only be performed in a window with a single tab and a single pane, to prevent accidental data loss.")
    return
  end

  local initial_pane = window:active_pane()
  local foreground_process = initial_pane:get_foreground_process_name()

  -- Check if the foreground process is a shell
  if foreground_process:find("sh") or foreground_process:find("cmd.exe") or foreground_process:find("powershell.exe") or foreground_process:find("pwsh.exe") or foreground_process:find("nu") then
    -- Safe to close
    initial_pane:send_text("exit\r")
  else
    wezterm.log_info("Active program detected. Skipping exit command for initial pane.")
  end

  -- Recreate tabs and panes from the saved state
  for _, tab_data in ipairs(workspace_data.tabs) do
    local cwd_uri = tab_data.panes[1].cwd
    local cwd_path = extract_path_from_dir(cwd_uri)

    local new_tab = window:mux_window():spawn_tab({ cwd = cwd_path })
    if not new_tab then
      wezterm.log_info("Failed to create a new tab.")
      break
    end

    -- Activate the new tab before creating panes
    new_tab:activate()

    -- Recreate panes within this tab
    for j, pane_data in ipairs(tab_data.panes) do
      local new_pane
      if j == 1 then
        new_pane = new_tab:active_pane()
      else
        local direction = 'Right'
        if pane_data.left == tab_data.panes[j - 1].left then
          direction = 'Bottom'
        end

        new_pane = new_tab:active_pane():split({
          direction = direction,
          cwd = extract_path_from_dir(pane_data.cwd)
        })
      end

      if not new_pane then
        wezterm.log_info("Failed to create a new pane.")
        break
      end

      -- Restore TTY for Neovim on Linux
      -- NOTE: cwd is handled differently on windows. maybe extend functionality for windows later
      -- This could probably be handled better in general
      if not (os == "x86_64-pc-windows-msvc") then
        if not (os == "x86_64-pc-windows-msvc") and pane_data.tty:sub(- #"/bin/nvim") == "/bin/nvim" then
          new_pane:send_text(pane_data.tty .. " ." .. "\n")
        else
          -- TODO - With running npm commands (e.g a running web client) this seems to execute Node, without the arguments
          new_pane:send_text(pane_data.tty .. "\n")
        end
      end
    end
  end

  wezterm.log_info("Workspace recreated with new tabs and panes based on saved state.")
  return true
end

--- Loads data from a JSON file.
-- @param file_path string: The file path from which the JSON data will be loaded.
-- @return table or nil: The loaded data as a Lua table, or nil if loading failed.
local function load_from_json_file(file_path)
  local file = io.open(file_path, "r")
  if not file then
    wezterm.log_info("Failed to open file: " .. file_path)
    return nil
  end

  local file_content = file:read("*a")
  file:close()

  local data = wezterm.json_parse(file_content)
  if not data then
    wezterm.log_info("Failed to parse JSON data from file: " .. file_path)
  end
  return data
end

--- Loads the saved json file matching the current workspace.
function session_manager.restore_state(window)
  local workspace_name = window:active_workspace()
  local file_path = wezterm.home_dir ..
      "/.config/wezterm/wezterm-session-manager/wezterm_state_" .. workspace_name .. ".json"

  local workspace_data = load_from_json_file(file_path)
  if not workspace_data then
    window:toast_notification('WezTerm',
      'Workspace state file not found for workspace: ' .. workspace_name, nil, 4000)
    return
  end

  if recreate_workspace(window, workspace_data) then
    window:toast_notification('WezTerm', 'Workspace state loaded for workspace: ' .. workspace_name,
      nil, 4000)
  else
    window:toast_notification('WezTerm', 'Workspace state loading failed for workspace: ' .. workspace_name,
      nil, 4000)
  end
end

--- Allows to select which workspace to load
function session_manager.load_state(window)
  -- TODO: Implement
  -- Placeholder for user selection logic
  -- ...
  -- TODO: Call the function recreate_workspace(workspace_data) to recreate the workspace
  -- Placeholder for recreation logic...
end

--- Orchestrator function to save the current workspace state.
-- Collects workspace data, saves it to a JSON file, and displays a notification.
function session_manager.save_state(window)
  local data = retrieve_workspace_data(window)

  -- Construct the file path based on the workspace name
  local file_path = wezterm.home_dir .. "/.config/wezterm/wezterm-session-manager/wezterm_state_" .. data.name .. ".json"

  -- Save the workspace data to a JSON file and display the appropriate notification
  if save_to_json_file(data, file_path) then
    window:toast_notification('WezTerm Session Manager', 'Workspace state saved successfully', nil, 4000)
  else
    window:toast_notification('WezTerm Session Manager', 'Failed to save workspace state', nil, 4000)
  end
end

return session_manager
