# Use fzf to search through the fd-results via fd (https://github.com/sharkdp/fd) to include hidden files (but exclude .git folders) and respect .gitignore
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

FZF_COLORS="bg:-1,\
bg+:-1,\
fg:-1,\
fg+:#ad9c8b,\
hl:#d8a851,\
hl+:#ceb250,\
header:#ad9c8b,\
border:#6B503C,\
info:#6b503c,\
prompt:#6b503c,\
pointer:#6b503c,\
marker:#7f61b3,\
spinner:#6b503c"

# https://vitormv.github.io/fzf-themes/
export FZF_DEFAULT_OPTS="--height 60% \
--border sharp \
--layout reverse \
--color '$FZF_COLORS' \
--prompt '∷ ' \
--pointer ▶ \
--marker '✔ ' \
--bind='ctrl-o:execute(code {})+abort' \
--bind 'ctrl-/:change-preview-window(hidden|)' \
--preview-window='border-sharp' \
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
