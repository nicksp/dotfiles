#!/bin/bash

# ~/.macos — https://mths.be/macos

if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "Configuring macOS with sane defaults…"
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

# Menu bar: disable transparency
defaults write com.apple.universalaccess reduceTransparency -bool true

# Menu bar: hide percentage
defaults write com.apple.menuextra.battery ShowPercent -string "NO"

# Set accent color to Graphite
defaults write -g AppleAquaColorVariant -int 6

# Set highlight color to #AC9BC5
defaults write NSGlobalDomain AppleHighlightColor -string "0.674510 0.607843 0.772549 Other"

# Set sidebar icon size to Large
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 3

# Show scroll bars when scrolling
# Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Fill window when double-clicking its title bar
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Fill"

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Enable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool true

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Enable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool true

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Trackpad, mouse, keyboard, and input                                        #
###############################################################################

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Trackpad: disable swipe between pages
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en-US" "ru-RU"
defaults write NSGlobalDomain AppleLocale -string "en_US@rg=ruzzzz"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
#sudo systemsetup -settimezone "Europe/Brussels" > /dev/null

# Don't illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool false
# Turn off keyboard backlight when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

###############################################################################
# Energy saving                                                               #
###############################################################################

# Enable lid wakeup
sudo pmset -a lidwake 1

# Restart automatically after shutdown due to a power failure or system crash
sudo pmset -a autorestart 1

# Put the hard disk(s) to sleep when possible: 10 min
sudo pmset -a disksleep 10

# Disable wake for network access
sudo pmset -a womp 0

# Battery

# Computer sleep: 10 min
sudo pmset -b sleep 10

# Display sleep: 5 min
sudo pmset -b displaysleep 5

# Slightly dim the display on battery
sudo pmset -b lessbright 1

# Power Adapter

# Computer sleep: 30 min
sudo pmset -c sleep 30

# Display sleep: 15 min
sudo pmset -c displaysleep 15

# Hibernation mode
# 0: Disable hibernation (speeds up entering sleep mode)
# 3: Copy RAM to disk so the system state can still be restored in case of a
#    power failure.
sudo pmset -a hibernatemode 3

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

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Security                                                                    #
###############################################################################

# Enable Firewall Service
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Enable Stealth Mode (Prevent others from discovering your Mac)
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Set Downloads as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/Downloads/"

# Show icons for hard drives and external disks on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show sidebar
defaults write com.apple.finder ShowSidebar -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Increase grid spacing for icons on the desktop and in other icon views
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist

# Enable Stacks view on the desktop
defaults write com.apple.finder DesktopViewSettings -dict-add GroupBy -string "Kind"

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Finder: disable sounds
# defaults write com.apple.finder FinderSounds -boolean false

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Expand the following File Info panes:
# “General”, “More Info”, “Open with”, “Preview”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  MetaData -bool true \
  OpenWith -bool true \
  Preview -bool true \
  Privileges -bool true

###############################################################################
# Dock and hot corners                                                        #
###############################################################################

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 38 pixels
defaults write com.apple.dock tilesize -int 38

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "suck"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Show only currently running applications in the Dock
#defaults write com.apple.dock static-only -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool true

# Disable icon bouncing
defaults write com.apple.dock no-bouncing -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Set 0.5 second delay when auto-hiding the Dock
defaults write com.apple.dock autohide-delay -float 0.5

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don’t show suggested and recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Reset Launchpad, but keep the desktop wallpaper intact
find "$HOME/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Add iOS & Watch Simulator to Launchpad
#sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
#sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app"

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top left screen corner → ⌥ Launchpad
defaults write com.apple.dock wvous-tl-corner -int 11
defaults write com.apple.dock wvous-tl-modifier -int 524288
# Top right screen corner → Put Display to Sleep
defaults write com.apple.dock wvous-tr-corner -int 10
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → ⌥ Application Windows
defaults write com.apple.dock wvous-bl-corner -int 3
defaults write com.apple.dock wvous-bl-modifier -int 524288
# Bottom right screen corner → ⌥ Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 524288

###############################################################################
# Mail                                                                        #
###############################################################################

# Disable send and reply animations in Mail.app
#defaults write com.apple.mail DisableReplyAnimations -bool true
#defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
#defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
#defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

# Display emails in threaded mode, sorted by date (oldest at the top)
#defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
#defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
#defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# Disable inline attachments (just show the icons)
#defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Always show Safari's "URL display" tab in the lower left on mouseover
defaults write com.apple.Safari ShowOverlayStatusBar -bool true

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Warn when visiting a fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Warn before connecting to a website over HTTP
defaults write com.apple.Safari WarnAboutNonSecureWebsites -bool true

# Disable plug-ins
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Disable Java
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Remove Spotlight from menu bar (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
# 	MENU_DEFINITION
# 	MENU_CONVERSION
# 	MENU_EXPRESSION
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "SOURCE";}' \
  '{"enabled" = 1;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
  '{"enabled" = 1;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}'
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

# Spotlight search shortcut: none
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{ enabled = 0; value = { parameters = (65535, 49, 1048576); type = standard; }; }"

# Menu Bar Spotlight shortcut: none
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "{ enabled = 0; value = { parameters = (65535, 49, 1572864); type = standard; }; }"

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 100

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# TextEdit and QuickTime Player                                               #
###############################################################################

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Auto-play videos when opened with QuickTime Player
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install system data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

###############################################################################
# Preview                                                                     #
###############################################################################

# Do not open previous previewed files (e.g. PDFs) when opening a new one
defaults write com.apple.Preview ApplePersistenceIgnoreState YES

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Messages                                                                    #
###############################################################################

# Disable automatic emoji substitution (i.e. use plain text smileys)
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
  "Calendar" \
  "Dock" \
  "Finder" \
  "Mail" \
  "Messages" \
  "NotificationCenter" \
  "Photos" \
  "Safari" \
  "SystemUIServer" \
  "Terminal"; do
  killall "$app" > /dev/null 2>&1
done
echo "Done! Note that some of these changes require a logout/restart to take effect."
