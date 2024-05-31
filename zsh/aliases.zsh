# TIP: for a full list of active aliases, run `alias

# Enable aliases to be sudo’ed
alias sudo="sudo "

# Easier navigation
alias .='pwd'
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'
alias cd..='cd ..'
alias -- -="cd -" # previous working directory

# Hot-access directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias projects="cd $WORKSPACE"

# zshrc config
alias zshrc="$EDITOR ~/.zshrc"
alias reload="source ~/.zshrc && echo 'Shell config reloaded from ~/.zshrc'"

# Sane defaults for built-ins (verbose and interactive)
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias grep="grep -i --color=auto"

# Typos
alias sl="ls"
alias gut="git"
alias gti="git"
alias mdkir="mkdir"
alias brwe="brew"

# Shortcuts
alias ls="ls --color"
alias l="ls -l"
alias -- +x="chmod +x"
alias o="open"
alias oo="open ."
alias g="git"
alias v="nvim"
alias vim="nvim"
alias e="$EDITOR"
alias c="code ."
alias where="which"
alias pn="pnpm"

# Apps

# Git client
alias t="open -a 'Tower' ."

# Lazydocker
alias ld="lazydocker"

# Lazygit
alias lg="lazygit --use-config-dir $DOTFILES/lazygit"

# File Manager
alias nn="open -a 'Marta' ."

#
# Built-ins upgrades
#

command_exists() {
  command -v "$@" &> /dev/null
}

# Bat: https://github.com/sharkdp/bat
command_exists bat && alias cat="bat --style=plain"

# Eza: https://eza.rocks/
command_exists eza && alias ls="eza -a --no-user --no-time"
command_exists eza && alias ll="eza -a --no-user --long --header -g --icons --git"
command_exists eza && alias llt="eza -a --icons --tree --git-ignore"

# Safer reversible file removal: https://github.com/sindresorhus/trash-cli
command_exists trash && alias rm="trash"

# Htop: https://htop.dev/
command_exists htop && alias top="htop"

# Tldr: https://tldr.sh/
command_exists tldr && alias man="tldr"
command_exists tldr && alias help="tldr"

# Prettyping: https://denilson.sa.nom.br/prettyping/
command_exists prettyping && alias ping="prettyping --nolegend"

# Download file and save it with the name of the remote file in the current working directory
# Usage: get <URL>
alias get="curl -O -L"

#
# Helpers
#

# Most used Git shortcuts
alias gs="git status"
alias gss="git status -sb"
alias gd="git diff"
alias gp="pull --recurse-submodules"
alias gl="git log --graph --pretty=format:'%C(magenta)%h%Creset%C(auto)%d%Creset %s %C(blue bold)— %cr ~ %an%Creset'"
alias gpu="push"
alias gpuf="push --force-with-lease"

# Preview and open files in the current dir
command_exists fzf && command_exists bat && alias preview="fzf --preview 'bat --color \"always\" {}'"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Cd to the root directory of the current Git repository
alias gitroot='cd "$(git rev-parse --show-toplevel)"'
alias gr="gitroot"

# Cd into the directory shown by the front-most Finder window
# Based on https://scriptingosx.com/2017/02/terminal-finder-interaction/
cdf() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

# Make a new directory and cd into it
mkcd() {
  \mkdir -p "$1" && cd "$1"
}

# git clone and cd to a repo directory
clonecd() {
  git clone "$@"
  if [ "$2" ]; then
    cd "$2"
  else
    cd $(basename "$1" .git)
  fi
  if [[ -r "./yarn.lock" ]]; then
    yarn
  elif [[ -r "./package-lock.json" ]]; then
    npm install
  fi
}

#
# macOS
#

# System
alias shutdownmac="sudo shutdown -h now"
alias restartmac="sudo shutdown -r now"

# Show/hide all desktop icons (useful when presenting)
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
