# Organized to match the Z Shell Manual's "Options" chapter
# https://zsh.sourceforge.io/Doc/Release/Options.html
#
# TIPS:
#   1) You can list the existing shell options with the `setopt` command.
#   2) You can get a list of all default zsh options with the `emulate -lLR zsh` command.
#   3) You can revert the options for the current shell to the default settings with the `emulate -LR zsh` command.

#
# Changing Directories
#

# Do not cd by typing directory name if it's not a command
setopt no_auto_cd
# Never print the working directory after a cd
setopt cd_silent

#
# Completion
#

# ref: Options are defined in ./completion.zsh

#
# Expansion and Globbing
#

# Case insensitive globbing to mimic macOS file system behavior
setopt no_case_glob
# Enable extended globbing via additional pattern matching capabilities
setopt extended_glob

#
# History
#

# Remove older duplicate commands from the history list, keep newest
setopt hist_ignore_all_dups
# Do not find duplicate commands when searching
setopt hist_find_no_dups
# Remove superfluous blanks from history items
setopt hist_reduce_blanks
# When using history expansion (!!, !$, etc.), present for user confirmation/editing
setopt hist_verify
# Do not append history entries to the history file
# NOTE: This has to be turned off for shared history to work.
setopt no_inc_append_history
# Disable writing out the history entry to the file after the command is finished.
# NOTE: This has to be turned off for shared history to work.
setopt no_inc_append_history_time
# Share history between different instances of the shell
setopt share_history

#
# "Input/Output"
#

# Prevent existing files from being overwritten by redirection operations (`>`).
# You can still override this with `>|`.
setopt no_clobber
# Autocorrect commands with typos and ask to run the correct command instead
setopt correct # commands
setopt correct_all # all arguments
# Allow comments in interactive shells (like Bash does)
setopt interactive_comments
