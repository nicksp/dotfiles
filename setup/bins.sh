#!/bin/bash

# Make custom binary scripts executable

set -euo pipefail

cd "$(dirname "$0")/.."

DOTFILES_DIR="$(pwd)"

info() {
  printf "  [ \033[00;34m..\033[0m ] $1"
  echo
}

info 'Changing access permissions for binary scripts...'
find "$DOTFILES_DIR/bin" -type f -not -name '.DS_Store' -not -name 'README.md' -exec chmod +x {} \; -exec bash -c 'printf "\r\033[2K  [ \033[00;32m✔\033[0m ] set for %s\n" "${0##*/}"' {} \;
echo
echo 'Done!'
