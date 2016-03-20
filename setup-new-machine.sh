# Copy paste this file in bit by bit.
# Don't run it.

echo "Do not run this script in one go. Hit Ctrl-C NOW"
read -n 1

###############################################################################
# Backup old machine's dotfiles                                               #
###############################################################################

mkdir -p ~/migration/home
cd ~/migration

# then compare brew-list to what's in `brew.sh`
#   comm <(sort brew-list.txt) <(sort brew.sh-cleaned-up)

# let's hold on to these

cp ~/.extra ~/migration/home
cp ~/.z ~/migration/home
cp -R ~/.ssh ~/migration/home
cp /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist ~/migration  # wifi
cp ~/Library/Preferences/net.limechat.LimeChat.plist ~/migration
cp ~/Library/Preferences/com.tinyspeck.slackmacgap.plist ~/migration
cp -R ~/Library/Services ~/migration # automator stuff
cp -R ~/Documents ~/migration
cp ~/.bash_history ~/migration # back it up for fun?
cp ~/.gitconfig.local ~/migration
cp ~/.z ~/migration # z history file.

# sublime text settings
cp "~/Library/Application Support/Sublime Text 3/Packages" ~/migration


# iTerm settings.
  # Prefs, General, Use settings from Folder

# Finder settings


###############################################################################
# XCode Command Line Tools                                                    #
###############################################################################

if ! xcode-select --print-path &> /dev/null; then

  # Prompt user to install the XCode Command Line Tools
  xcode-select --install &> /dev/null

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Wait until the XCode Command Line Tools are installed
  until xcode-select --print-path &> /dev/null; do
    sleep 5
  done

  print_result $? 'Install XCode Command Line Tools'

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Point the `xcode-select` developer directory to
  # the appropriate directory from within `Xcode.app`
  # https://github.com/alrra/dotfiles/issues/13

  sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
  print_result $? 'Make "xcode-select" developer directory point to Xcode'

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Prompt user to agree to the terms of the Xcode license
  # https://github.com/alrra/dotfiles/issues/10

  sudo xcodebuild -license
  print_result $? 'Agree with the XCode Command Line Tools licence'

fi


###############################################################################
# Homebrew                                                                    #
###############################################################################

$HOME/dotfiles/install/brew.sh
$HOME/dotfiles/install/brew-cask.sh


###############################################################################
# Node                                                                        #
###############################################################################

$HOME/dotfiles/install/npm.sh

# Type `git open` to open the GitHub page or website for a repository.
npm install -g git-open
# trash as the safe `rm` alternative
npm install -g trash-cli


###############################################################################
# Git                                                                         #
###############################################################################

# github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
bash < <( curl https://raw.github.com/jamiew/git-friendly/master/install.sh)


###############################################################################
# Z                                                                           #
###############################################################################

# github.com/rupa/z - hooked up in .zshrc
# consider reusing your current .z file if possible. it's painful to rebuild :)
# or use autojump instead https://github.com/wting/autojump
git clone https://github.com/rupa/z.git ~/z
chmod +x ~/z/z.sh


# my magic photobooth symlink -> dropbox. I love it.
#    + first move Photo Booth folder out of Pictures
#    + then start Photo Booth. It'll ask where to put the library.
#    + put it in Dropbox/public
#   * Now… you can record photobooth videos quickly and they upload to dropbox DURING RECORDING
#   * then you grab public URL and send off your video message in a heartbeat.


# for the c alias (syntax highlighted cat)
sudo easy_install Pygments


###############################################################################
# Atom                                                                        #
###############################################################################

ln -s /Applications/Atom.app/Contents/Resources/app/atom.sh /usr/local/bin/atom


###############################################################################
# OSX defaults                                                                #
# https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
###############################################################################

sh osx/set-defaults.sh


###############################################################################
# Symlinks to link dotfiles into ~/                                           #
###############################################################################

./setup.sh
