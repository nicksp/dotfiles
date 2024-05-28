#!/bin/bash

set -euo pipefail

bold=$(tput bold)
reset=$(tput sgr0)

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

# GitHub CLI: Authenticate with your GitHub account if the user is not logged in
if command_exists gh && ! gh auth status &> /dev/null; then
  echo "[GitHub CLI] You are not logged into any GitHub hosts. To log in, run: ${bold}gh auth login${reset}"
fi

# Node.js global config
npm config set loglevel warn
npm config set save-exact true

# Npm packages
packages=(
  npm-upgrade
  yo
)
npm install -g "${packages[@]}"
