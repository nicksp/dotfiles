# Use fzf to search through the fd-results via fd (https://github.com/sharkdp/fd) to include hidden files (but exclude .git folders) and respect .gitignore
# See more: https://github.com/junegunn/fzf/blob/master/ADVANCED.md
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

# CTRL-T − Paste the selected files onto the command-line.
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"

# ALT-C − cd into the selected directory.
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {}'"

# CTRL-R − Paste the selected command from history onto the command-line.
# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window down:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS='--border --info=inline'

# Squirrelsong Dark Deep Purple theme colors
FZF_COLORS="fg:-1,\
fg+:#bea3d9,\
bg:-1,\
bg+:#bea3d9,\
hl:#ca5a83,\
hl+:#97576f,\
info:#7254a6,\
marker:#ceb250,\
prompt:#7254a6,\
spinner:#bea3d9,\
pointer:#bea3d9,\
header:#e9d6fa,\
border:#644e88,\
label:#bea3d9,\
query:#e9d6fa,\
disabled:#7254a6"

# https://vitormv.github.io/fzf-themes/
export FZF_DEFAULT_OPTS="--height 60% \
--border rounded \
--layout reverse \
--color '$FZF_COLORS' \
--prompt '▶ ' \
--pointer ▪︎ \
--marker '✔ ' \
--bind='ctrl-o:execute(code {})+abort' \
--bind 'ctrl-/:change-preview-window(hidden|)' \
--preview-window='border-rounded' \
--info right"

# Use fd to respect .gitignore, include hidden files and exclude `.git` folders
# - The first argument to the function ($1) is the base path to start traversal
_fzf_compgen_path() {
  fd --hidden --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - Make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    # cd **<TAB>
    cd)      fzf --preview 'eza --tree --color=always {} | head -200'                        "$@" ;;
    # llt **<TAB>
    llt)     fd --type d --hidden | fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    # any_other_command **<TAB>
    *)       fzf --preview 'bat -n --color=always {}'                                        "$@" ;;
  esac
}

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
