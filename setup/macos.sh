#!/bin/bash

# ~/.macos — https://mths.be/macos

if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "Configuring macOS with sane defaults..."
  echo
else
  exit 0
fi

COMPUTERNAME='Nick M1 Air'
LOCALHOSTNAME='nickmac.air'

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
#sudo scutil --set ComputerName $COMPUTERNAME
#sudo scutil --set HostName $COMPUTERNAME
#sudo scutil --set LocalHostName $LOCALHOSTNAME
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $LOCALHOSTNAME

# Reduce startup sound volume
sudo nvram SystemAudioVolume="%80"

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type png

# Disable shadow in window captures
defaults write com.apple.screencapture disable-shadow -bool true

# Show the mouse pointer in screenshots
defaults write com.apple.screencapture showsCursor -bool true

# Change the default screenshot name
defaults write com.apple.screencapture name "Shot"

###############################################################################
# Preview                                                                     #
###############################################################################

# Do not open previous previewed files (e.g. PDFs) when opening a new one
defaults write com.apple.Preview ApplePersistenceIgnoreState YES

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
  "Address Book" \
  "Calendar" \
  "Contacts" \
  "Dashboard" \
  "Dock" \
  "Finder" \
  "Google Chrome Canary" \
  "Google Chrome" \
  "Mail" \
  "Messages" \
  "NotificationCenter" \
  "Photos" \
  "Safari" \
  "SystemUIServer" \
  "Terminal" \
  "iCal"; do
  killall "${app}" > /dev/null 2>&1
done
echo "Done! Note that some of these changes require a logout/restart to take effect."
