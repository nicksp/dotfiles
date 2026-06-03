typeset -U fpath

# Terminal integrations (i.e. cmux) can run before .zshrc.
# Avoid stale Homebrew Cellar zsh function paths so early autoloads like add-zsh-hook and is-at-least work as intended.
if [[ -d /opt/homebrew/opt/zsh/share/zsh/functions ]]; then
  fpath=(/opt/homebrew/opt/zsh/share/zsh/functions ${fpath:#/opt/homebrew/Cellar/zsh/*/share/zsh/functions})
fi
