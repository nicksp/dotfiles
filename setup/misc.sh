#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")/.."

eval "$(/opt/homebrew/bin/brew shellenv)"

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
info "🚀 Installing Node.js dependencies…"
# Less verbose output
npm config set loglevel warn
# Disable funding messages
npm config set fund false
# Install exact version of packages ("1.2.3" instead of "^1.2.3" or "~1.2.3"). Keeps pinning durable
npm config set save-exact true
# Do not allow installing packages from Git
npm config set allow-git none
# Do not allow installing packages from a file
# npm config set allow-file none
# Do not allow installing packages from remote dependencies (URLs instead of npm registry)
# npm config set allow-remote none
# Only install package versions published at least 7 days ago
npm config set min-release-age 7

# Npm packages
packages=(
  npm-upgrade
  aws-cdk
  serverless
  @sourcegraph/amp
  @antfu/ni
)
npm install -g "${packages[@]}"
