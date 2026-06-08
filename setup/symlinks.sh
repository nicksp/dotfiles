#!/bin/bash

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
TILDE_DIR="$DOTFILES_DIR/tilde"

EXCLUDE_FILES=(".DS_Store" "Brewfile.lock.json" "README.md" ".codex")

indent() {
  sed 's/^/  /'
}

tildify() {
  printf '%s' "${1/#$HOME/~}"
}

info() {
  printf "$1" | indent
  echo
}

user() {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success() {
  printf "\r\033[2K   $1\n"
}

skipped() {
  printf "\r\033[2K  [skipped]  $1\n"
}

fail() {
  printf "\r\033[2K  [\033[0;31m✖\033[0m] $1\n"
  echo ''
  exit
}

symlink_file() {
  local src=$1 dst=$2 isHardLink=${3:-false}

  local overwrite
  local backup
  local skip
  local action

  if [ ! -d "$(dirname "$dst")" ]; then
    mkdir -p "$(dirname "$dst")"
  fi

  # First, check if the destination file or folder exists
  if [ -e "$dst" ]; then

    # Check if the destination is a hard link to the same inode as the source
    # (only meaningful when `isHardLink=true`, but `-ef` is harmless otherwise)
    if [ "$isHardLink" = true ] && [ "$dst" -ef "$src" ]; then
      # Already hard linked to the dotfiles source, skip overwriting
      skip=true

    # Check if the destination is a symlink
    elif [ -L "$dst" ]; then

      # Check if the destination is already a symlink to the dotfiles
      readlink_out=$(readlink "$dst")
      local current_src="$readlink_out"

      if [ "$current_src" == "$src" ]; then
        # Skip overwriting
        skip=true
      else
        # If the destination is a symlink to something else, ask to overwrite
        handle_existing_file
      fi

    else

      # If the destination is a regular file or directory, ask to overwrite
      handle_existing_file

    fi

  fi

  # "false" or empty
  if [ "$skip" != "true" ]; then
    local ln_cmd="ln"
    if [ ! -w "$(dirname "$2")" ]; then
      ln_cmd="sudo ln"
    fi

    if [ "$isHardLink" = true ]; then
      $ln_cmd -f "$1" "$2"
      success "$(tildify "$2")"
    else
      $ln_cmd -sf "$1" "$2"
      success "$(tildify "$2")"
    fi
  else
    skipped "$(tildify "$dst")"
  fi
}

handle_existing_file() {
  if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then
    user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
    [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
    read -n 1 action

    case "$action" in
      o)
        overwrite=true
        ;;
      O)
        overwrite_all=true
        ;;
      b)
        backup=true
        ;;
      B)
        backup_all=true
        ;;
      s)
        skip=true
        ;;
      S)
        skip_all=true
        ;;
      *) ;;

    esac
  fi

  overwrite=${overwrite:-$overwrite_all}
  backup=${backup:-$backup_all}
  skip=${skip:-$skip_all}

  if [ "$overwrite" == "true" ]; then
    rm -rf "$dst"
    success "removed $dst"
  fi

  if [ "$backup" == "true" ]; then
    mv "$dst" "${dst}.backup"
    success "moved $dst to ${dst}.backup"
  fi
}

install_dotfiles() {
  info 'Syncing dotfiles…'

  local overwrite_all=false
  local backup_all=false
  local skip_all=false

  # Create .config directory if it doesn't exist
  mkdir -p ~/.config

  cd "$TILDE_DIR"

  # Loop through all items in the `tilde` directory
  for item in .* *; do
    # Skip the current and parent directory entries
    if [ "$item" == "." ] || [ "$item" == ".." ]; then
      continue
    fi

    # Ignore exclude files
    for excluded in "${EXCLUDE_FILES[@]}"; do
      if [[ "$item" == "$excluded" ]]; then
        # Skip to the next iteration of the outer loop
        continue 2
      fi
    done

    # is a dotfile
    if [ -f "$item" ]; then
      src="$PWD/$item"
      dest="$HOME/$item"
      symlink_file "$src" "$dest"
    # is a dir with dotfiles
    elif [ -d "$item" ]; then
      if [ "$item" != ".config" ]; then
        src="$PWD/$item"
        dest="$HOME/$item"
        symlink_file "$src" "$dest"
      else
        # Handle the `.config` dir separately
        for config_item in "$item"/*; do
          src="$PWD/$config_item"
          dest="$HOME/$config_item"
          symlink_file "$src" "$dest"
        done
      fi
    fi
  done
}

install_extras() {
  local overwrite_all=false
  local backup_all=false
  local skip_all=false

  if [ ! -d "/usr/local/bin" ]; then
    echo "Administrator password required to create /usr/local/bin:"
    sudo mkdir -p "/usr/local/bin"
  fi

  # CotEditor: Install `cot` command-line tool
  command -v cot &> /dev/null || {
    symlink_file "/Applications/CotEditor.app/Contents/SharedSupport/bin/cot" "/usr/local/bin/cot"
  }

  #
  # VSCode
  #

  # Install `code` command in PATH
  command -v code &> /dev/null || {
    symlink_file "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" "/usr/local/bin/code"
  }
  # Enable settings sync from dotfiles
  vscode_user_folder="$HOME/Library/Application Support/Code/User"
  rm -rf "$vscode_user_folder"
  ln -sfn "$DOTFILES_DIR/vscode/User" "$vscode_user_folder"

  # Lazydocker
  symlink_file "$DOTFILES_DIR/lazydocker/config.yml" "$HOME/Library/Application Support/lazydocker/config.yml"

  # Lazygit
  symlink_file "$DOTFILES_DIR/lazygit/state.yml" "$HOME/Library/Application Support/lazygit/state.yml"

  # GPG
  symlink_file "$DOTFILES_DIR/gpg/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"

  # Quick-Look plugins to enhance experience using file manager
  symlink_file "$DOTFILES_DIR/ql-plugins" "$HOME/Library/QuickLook"

  # Firefox Developer Edition
  ff_dev_profile_dir="$("$DOTFILES_DIR"/firefox/lib/get-firefox-dev-path)"
  symlink_file "$DOTFILES_DIR/firefox/user.js" "$ff_dev_profile_dir/user.js" true
  rm -rf "$ff_dev_profile_dir/chrome"
  mkdir -p "$ff_dev_profile_dir/chrome"
  ln "$DOTFILES_DIR/firefox/chrome/userContent.css" "$ff_dev_profile_dir/chrome/userContent.css"
  ln "$DOTFILES_DIR/firefox/chrome/userChrome.css" "$ff_dev_profile_dir/chrome/userChrome.css"

  #
  # AI agents
  #

  AGENTS_DIR="$HOME/.agents"
  AGENTS_SETUP_DIR="$DOTFILES_DIR/agents"
  AGENTS_INSTRUCTIONS="$AGENTS_SETUP_DIR/instructions.md"

  #
  # Amp
  #

  # Base instructions
  symlink_file "$AGENTS_INSTRUCTIONS" "$HOME/.config/amp/AGENTS.md"

  #
  # Codex
  #

  # Base instructions
  symlink_file "$AGENTS_INSTRUCTIONS" "$HOME/.codex/AGENTS.md"
  # Configuration
  symlink_file "$DOTFILES_DIR/tilde/.codex/config.toml" "$HOME/.codex/config.toml"
}

install_dotfiles
install_extras
echo
echo 'Done!' | indent
