# Load configs
source $HOME/dotfiles/zsh/path.zsh
source $HOME/dotfiles/zsh/env.zsh
source $HOME/dotfiles/zsh/options.zsh
source $HOME/dotfiles/zsh/aliases.zsh
source $HOME/dotfiles/zsh/completion.zsh
source $HOME/dotfiles/zsh/key-bindings.zsh

# Load plugins
source $HOME/dotfiles/zsh/plugins/zsh-shift-select.plugin.zsh

# Set the window title nicely no matter where you are
DISABLE_AUTO_TITLE="true"
_set_terminal_title() {
  local title="$(basename "$PWD")"
  if [[ -n $SSH_CONNECTION ]]; then
    title="$title \xE2\x80\x94 $HOSTNAME"
  fi
  print -Pn "\e]2;$title\a"
}
# Call the function before displaying the prompt
precmd_functions+=(_set_terminal_title)

source $HOME/dotfiles/zsh/init.zsh

# Allow local (private) customizations (not checked in to version control)
[ -f ~/.zsh.local ] && source ~/.zsh.local

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Add GPG key
export GPG_TTY=$(tty)
