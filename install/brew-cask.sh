#!/bin/bash

# Install Caskroom
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install packages
apps=(
    gyazo
    dropbox
    google-drive
    spectacle
    flux
    dash
    iterm2
    atom
    webstorm
    firefox
    firefoxnightly
    google-chrome
    google-chrome-canary
    glimmerblocker
    hammerspoon
    kaleidoscope
    macdown
    opera
    screenflow
    #sourcetree
    spotify
    transmit
    vlc
    utorrent
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
