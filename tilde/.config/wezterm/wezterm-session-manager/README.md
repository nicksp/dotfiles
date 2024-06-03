# WezTerm Session Manager

The [WezTerm](https://wezfurlong.org/wezterm/) Session Manager is a Lua script enhancement for WezTerm that provides functionality to save, load, and restore terminal sessions. This tool helps manage terminal sessions, its goal is to save and restore different sessions or better workspaces and later restore them.

## Features

- **Save Session State** Captures the current layout of windows, tabs and panes, along with their working directories and foreground processes.
- **restore Session** Reopens a previously saved session that matches the current workspace name, restoring its layout and directories.
- **Load Session (Not implemented yet)** Allows selecting which saved session to load, regardless of the current workspace name.

## Installation

1. **Clone the Repository** Clone the Repository into your WezTerm configuration directory:

   ```bash
   git clone https://github.com/danielcopper/wezterm-session-manager.git ~/.config/wezterm/wezterm-session-manager
   ```

2. **Configure WezTerm:** Edit your 'wezterm.lua' file to include the Session Manager:

   ```lua
   local session_manager = require("wezterm-session-manager/session-manager")
   ```

3. **Setup Event Bindings:** Edit your 'wezterm.lua' to include the event bindings to trigger the functions of the session manager

   ```lua
   wezterm.on("save_session", function(window) session_manager.save_state(window) end)
   wezterm.on("load_session", function(window) session_manager.load_state(window) end)
   wezterm.on("restore_session", function(window) session_manager.restore_state(window) end)
   ```

4. **Set Keybindings:** Define Keybindings in your 'wezterm.lua' for saving, restoring and loading sessions:

   ```lua
   local wezterm = require 'wezterm';
   return {
     keys = {
      {key = "S", mods = "LEADER", action = wezterm.action{EmitEvent = "save_session"}},
      {key = "L", mods = "LEADER", action = wezterm.action{EmitEvent = "load_session"}},
      {key = "R", mods = "LEADER", action = wezterm.action{EmitEvent = "restore_session"}},
     },
   }
   ```

5. I also recommend to set up a keybinding for creating **named** workspaces as explained [here](https://wezfurlong.org/wezterm/config/lua/keyassignment/SwitchToWorkspace.html). This helps managing and switching states.

## Limitations

There are currently some limitations and improvements that need to be implemented:

- The script does not restore the state of running applications within each pane (except nvim on linux which seems to work fine but the general handling should be improved)
- It' primarily tested on Linux and Windows, expect some bugs or adjustements that need to be made
- Complex pane layouts won't be correctly restored, the current implementation to determine the pane position is extremely basic

## Contributing

Feedback, bug reports, and contributions to enhance the script are welcome.
