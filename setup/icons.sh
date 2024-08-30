#!/bin/bash

# Use alternative app icons
# https://www.sethvargo.com/replace-icons-osx/

set -euo pipefail

cd "$(dirname "$0")/.."

DOTFILES_DIR="$(pwd)"
ICONS_DIR="$DOTFILES_DIR/setup/_icons"

reset=$(tput sgr0)
bold=$(tput bold)

warning() {
  tput setaf 1
  echo "/!\\ $1 /!\\"
  tput sgr0
}

update_icon() {
  local app_name="$1"
  local app_path="$2"
  local icon_path="$3"
  local alt_icon_path="$4"

  if [ ! -f "$icon_path" ]; then
    echo "Can't find existing icon, make sure ${bold}${app_name}${reset} is installed."
    echo
  else
    cp "$alt_icon_path" "$icon_path"
    touch "$app_path"
  fi
}

# Ask for the administrator password upfront
warning "Activate sudo"
sudo echo "Sudo activated!"
echo

# Marta File Manager
# https://icon-icons.com/icon/floppy-disk/30728
update_icon "Marta" "/Applications/Marta.app" "/Applications/Marta.app/Contents/Resources/AppIcon.icns" "$ICONS_DIR/Floppy.icns"

# Spark Desktop
# https://macosicons.com/#/email%20003
update_icon "Spark Desktop" "/Applications/Spark Desktop.app" "/Applications/Spark Desktop.app/Contents/Resources/icon.icns" "$ICONS_DIR/Mail.icns"

# Git Tower
# https://dribbble.com/shots/1694053-Git-App-Icon
update_icon "Tower" "/Applications/Tower.app" "/Applications/Tower.app/Contents/Resources/Icon.icns" "$ICONS_DIR/Git.icns"

# WezTerm
# https://github.com/dhanishgajjar/terminal-icons?tab=readme-ov-file
update_icon "WezTerm" "/Applications/WezTerm.app" "/Applications/WezTerm.app/Contents/Resources/terminal.icns" "$ICONS_DIR/Terminal.icns"

# Visual Studio Code
# https://dribbble.com/shots/15424559-VS-Code-replacement-icon
update_icon "Visual Studio Code" "/Applications/Visual Studio Code.app" "/Applications/Visual Studio Code.app/Contents/Resources/Code.icns" "$ICONS_DIR/Code.icns"

# Vivaldi
# https://macosicons.com/#/Netscape%20Navigator
update_icon "Vivaldi" "/Applications/Vivaldi.app" "/Applications/Vivaldi.app/Contents/Resources/app.icns" "$ICONS_DIR/Browser.icns"

# Arc
# TODO: The default icon gets restored after the app restart
# https://dribbble.com/shots/18601645-Arc-The-Browser-Company
update_icon "Arc" "/Applications/Arc.app" "/Applications/Arc.app/Contents/Resources/AppIcon.icns" "$ICONS_DIR/Arc.icns"

# Zoom
# https://dribbble.com/shots/23820258-Zoom-MacOS-Replacement-Icon

# Reset caches and restart Dock
sudo rm -rf /Library/Caches/com.apple.iconservices.store
killall Dock

echo "🦄 Applications now use alternative icons."
