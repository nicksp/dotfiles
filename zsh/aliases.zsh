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
alias library="cd $HOME/Library"
alias projects="cd $WORKSPACE"

# zshrc config
alias zshrc="$EDITOR ~/.zshrc"
alias reload="source ~/.zshrc && echo 'Shell config reloaded from ~/.zshrc'"
alias s="reload"

# Sane defaults for built-ins (verbose and interactive)
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias grep="grep -i --color=auto"
alias mkdir="mkdir -p"

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
alias d="docker"
alias dc="docker compose"
alias e="$EDITOR"
alias c="code ."
alias cc="code ."
alias where="which"
alias pn="pnpm"
alias nvm="fnm"
# List the long form of the GPG keys for which you have both a public and private key
alias gpgkeys="gpg --list-secret-keys --keyid-format=long"

# Apps

# Git client
alias t="github ."

# Lazydocker
alias ld="lazydocker"

# Lazygit
alias lg="lazygit --use-config-dir $DOTFILES/lazygit"

# File Manager
alias ff="open -a 'Marta' ."

#
# Built-ins upgrades
#

command_exists() {
  command -v "$@" &> /dev/null
}

# Bat: https://github.com/sharkdp/bat
command_exists bat && alias cat="bat --style=plain"

# Fd: https://github.com/sharkdp/fd
command_exists fd && alias find="fd"

# Eza: https://eza.rocks/
# Display all clickable entries (incl. hidden files) as a grid with icons
command_exists eza && alias ls="eza -a --hyperlink --icons=auto --group-directories-first --color-scale=age"
# Display a detailed list of clickable entries (incl. hidden files) with a Git status
command_exists eza && alias ll="ls --long --no-user --header -g --git"
# Display clickable directory tree
command_exists eza && alias llt="ls --tree --git-ignore"

# Safer reversible file removal: https://github.com/sindresorhus/trash-cli
command_exists trash && alias rm="trash"

# Htop: https://htop.dev/
command_exists htop && alias top="htop"

# Tlrc: https://github.com/tldr-pages/tlrc
command_exists tldr && alias man="tldr --config ~/.tlrc.toml"

# Prettyping: https://denilson.sa.nom.br/prettyping/
command_exists prettyping && alias ping="prettyping --nolegend"

# Download file and save it with the name of the remote file in the current working directory
# Usage: get <URL>
alias get="curl -O -L"

#
# Helpers
#

# Most used Git shortcuts
alias gs="git rev-parse --git-dir > /dev/null 2>&1 && git status || ls"
alias gss="git rev-parse --git-dir > /dev/null 2>&1 && git status -sb || ls"
alias gc="git commit"
alias gcb="git switch"
alias gaa="git add -A"
alias gd="git diff"
alias gdc="git diff --cached"
alias gp="pull --recurse-submodules"
alias gl="git log --graph --pretty=format:'%C(magenta)%h%Creset%C(auto)%d%Creset %s %C(blue bold)— %cr ~ %an%Creset' -30"
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
take() {
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
  elif [[ -r "./pnpm-lock.yaml" ]]; then
    pnpm install
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
