#!/bin/bash

# Note: Zsh is now the default shell for all newly created user accounts,
# starting with macOS Catalina: https://support.apple.com/en-us/102360
#
# Installs up-to-date zsh and registers it as the default shell
# https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH

set -euo pipefail

bold=$(tput bold)
reset=$(tput sgr0)

warning() {
  tput setaf 1
  echo "/!\\ $1 /!\\"
  tput sgr0
}

title() {
  echo "${bold}==> $1${reset}"
  echo
}

# We're all good already
if [ "$SHELL" == "/opt/homebrew/bin/zsh" ]; then
  echo "Nothing to update. You're already using zsh as your default shell 👏"
  exit 0
fi

# Ask for the administrator password upfront
warning "Activate sudo"
sudo echo "Sudo activated!"
echo

zsh_path=$(which zsh)

# To work around an error for non-standard shell,
# ensure zsh is a valid shell option
if ! cat /etc/shells | grep $zsh_path > /dev/null; then
  title "Adding zsh to list of allowed shells..."
  sh -c "echo $zsh_path >> /etc/shells"
  echo
fi

# Set the default shell to ZSH
title "Changing your shell to $zsh_path..."
chsh -s "$zsh_path"
echo "Your shell has been changed to zsh, please restart your terminal or tab"
echo
