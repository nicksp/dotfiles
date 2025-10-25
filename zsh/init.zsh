command_exists() {
  command -v "$@" &> /dev/null
}

source_brew_plugin() {
  command_exists brew || return 1
  local plugin_path="$(brew --prefix)/share/$1/$1.zsh"
  [[ -r "$plugin_path" ]] && source "$plugin_path"
}

# Activate Fish-like autosuggestions: https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#homebrew
source_brew_plugin "zsh-autosuggestions"

# Enable Fish-like syntax highlighting: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
# Custom colors
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=blue'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[assign]='fg=blue'
ZSH_HIGHLIGHT_STYLES[comment]='fg=black'
# Load plugin
source_brew_plugin "zsh-syntax-highlighting"

# Enable fzf: https://github.com/junegunn/fzf
if command_exists fzf; then
  source $HOME/dotfiles/zsh/fzf.zsh
fi

# Setup zoxide: https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
export _ZO_DATA_DIR=$HOME
if command_exists zoxide; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# Starship prompt
if command_exists starship; then
  export STARSHIP_CONFIG=~/.starship.toml
  eval "$(starship init zsh)"
fi
