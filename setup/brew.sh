#!/bin/bash

set -euo pipefail

bold=$(tput bold)
reset=$(tput sgr0)

title() {
  echo "${bold}==> $1${reset}"
  echo
}

indent() {
  sed 's/^/  /'
}

# Check for Homebrew and install it if required
if ! command -v brew &> /dev/null; then
  title "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make sure we’re working with the latest version of Homebrew and its formulae
brew update

# Upgrade outdated already-installed formulae
brew upgrade

# Install fonts, tools, apps & vscode extensions
title "Installing software..."
brew bundle --file=./setup/Brewfile | indent

# Extra apps
echo ""
title "☕️ Install more apps if you need them:"
echo "brew install --cask daisydisk"
echo "brew install --cask dbngin"
echo "brew install --cask figma"
echo "brew install --cask ibkr"
echo "brew install --cask zoom"
echo "${bold}Contrast${reset} − https://github.com/soffes/contrast"
echo "${bold}Audirvāna Origin${reset} − https://audirvana.com/audirvana-origin/"

# App Store apps
echo ""
title "🍏 Install additional apps from App Store:"
echo "https://apps.apple.com/us/app/bear-markdown-notes/id1091189122?mt=12"
echo "https://apps.apple.com/us/app/colorslurp/id1287239339"
echo "https://apps.apple.com/us/app/klack/id6446206067?mt=12"
echo "https://apps.apple.com/us/app/tadam/id531349534?mt=12"
echo "https://apps.apple.com/us/app/things-3/id904280696?mt=12"

# Remove outdated versions of formulae and casks from the cellar
# Besides, this will run `brew autoremove` to remove all the hanging, no longer needed packages
brew cleanup --prune=all
