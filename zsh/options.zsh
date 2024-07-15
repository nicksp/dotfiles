# Organized to match the Z Shell Manual's "Options" chapter
# https://zsh.sourceforge.io/Doc/Release/Options.html
#
# TIPS:
#   1) You can list the existing shell options with the `setopt` command.
#   2) You can get a list of all default zsh options with the `emulate -lLR zsh` command.
#   3) You can revert the options for the current shell to the default settings with the `emulate -LR zsh` command.

# This only sets options that exist
setopt_if_exists() {
  if [[ "${options[$1]+1}" ]]; then
    setopt "$1"
  fi
}

#
# Changing Directories
#

# Do not cd by typing directory name if it's not a command
setopt_if_exists no_auto_cd
# Never print the working directory after a cd
setopt_if_exists cd_silent

#
# Completion
# See also: https://zsh.sourceforge.io/Guide/zshguide06.html
#

# ref: Options are defined in ./completion.zsh

#
# Expansion and Globbing
# See also: https://zsh.sourceforge.io/Doc/Release/Expansion.html#Brace-Expansion
#

# Case insensitive globbing (to mimic macOS file system behavior)
setopt_if_exists no_case_glob
# Enable extended globbing via additional pattern matching capabilities
# More information: https://wiki.zshell.dev/community/zsh_guide/roadmap/expansion
setopt_if_exists extended_glob

#
# History
#

# Remove older duplicate commands from the history list, keep newest
setopt_if_exists hist_ignore_all_dups
# Do not find duplicate commands when searching
setopt_if_exists hist_find_no_dups
# Remove superfluous blanks from history items
setopt_if_exists hist_reduce_blanks
# Don't store commands prefixed with a space
setopt_if_exists hist_ignore_space
# When using history expansion (!!, !$, etc.), present for user confirmation/editing
setopt_if_exists hist_verify
# Do not append history entries to the history file
# NOTE: This has to be turned off for shared history to work.
setopt_if_exists no_inc_append_history
# Disable writing out the history entry to the file after the command is finished.
# NOTE: This has to be turned off for shared history to work.
setopt_if_exists no_inc_append_history_time
# Share history between different instances of the shell
setopt_if_exists share_history

#
# "Input/Output"
#

# Prevent existing files from being overwritten by redirection operations (`>`).
# You can still override this with `>|`.
setopt_if_exists no_clobber
# Autocorrect commands with typos and ask to run the correct command instead
setopt_if_exists correct # commands
setopt_if_exists correct_all # all arguments
# Allow comments in interactive shells (like Bash does)
setopt_if_exists interactive_comments

unset setopt_if_exists
