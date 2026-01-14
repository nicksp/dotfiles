#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")/.."

DOTFILES_DIR="$(pwd)"

BLUE=$(tput setaf 4)
BOLD=$(tput bold)
RESET=$(tput sgr0)

indent() {
  sed 's/^/  /'
}

info() {
  echo
  echo "[ ${BLUE}..${RESET} ] $1" | indent
}

warning() {
  tput setaf 1
  echo "/!\\ $1 /!\\"
  tput sgr0
}

command_exists() {
  command -v "$@" &> /dev/null
}

# Ask for the administrator password upfront
warning "Activate sudo"
sudo echo "Sudo activated!"
echo

# Install Xcode Command Line Tools and accept its license
if ! xcode-select -p &> /dev/null; then
  xcode-select --install &> /dev/null

  # Wait until the Xcode Command Line Tools are installed
  until xcode-select -p &> /dev/null; do
    sleep 5
  done

  xcodebuild -license
fi

# Verify Xcode Command Line Tools successful installation
xcode-select -p

# Make custom binary scripts executable
info 'Changing access permissions for binary scripts…'
find "$DOTFILES_DIR/bin" -type f -not -name '.DS_Store' -not -name 'README.md' -exec chmod +x {} \; -exec bash -c 'printf "\r\033[2K  [ \033[00;32m✔\033[0m ] set for %s\n" "${0##*/}"' {} \;
echo
echo 'Done!' | indent
echo

# GitHub CLI: Authenticate with your GitHub account if the user is not logged in
if command_exists gh && ! gh auth status &> /dev/null; then
  echo "[GitHub CLI] You are not logged into any GitHub hosts. To log in, run: ${BOLD}gh auth login${RESET}"
fi

# Node.js global config
npm config set loglevel warn
npm config set fund false

# Npm packages
packages=(
  npm-upgrade
  aws-cdk
  serverless
  @sourcegraph/amp
  @antfu/ni
)
npm install -g "${packages[@]}"
