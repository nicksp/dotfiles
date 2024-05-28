#!/bin/bash

# Prepare Visual Studio Code

set -euo pipefail

cd "$(dirname "$0")/.."

DOTFILES_DIR="$(pwd)"

# Install `code` command in PATH
command -v code &> /dev/null || {
  ln -s "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" /usr/local/bin/code
}

# Enable settings sync from dotfiles
target_folder="$HOME/Library/Application Support/Code/User"
rm -rf $target_folder
mkdir -p $target_folder

ln -sfn "$DOTFILES_DIR/vscode/User"/* $target_folder
