#!/usr/bin/env bash

###############################################################################
# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


###############################################################################
# HOMEBREW
###############################################################################


###############################################################################
# Install Brew
# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi



###############################################################################
# BREW CASK
###############################################################################

# After you have homebrew installed, you'll want to install Homebrew Cask for installing Native Apps:
brew install homebrew/cask-cask
brew tap homebrew/cask-versions


# Install quicklook plugins: https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

# Apps
apps=(
  firefox
  iterm2
  optimal-layout
  visual-studio-code
  google-chrome
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}
# cleanup brew cask and bin files

# Archive... for use if you want
# Apps
# apps=(
#   flash
#   java
#   intellij-idea
#   phantomjs
#   alfred
#   dropbox
#   google-chrome
#   controlplane
#   qlcolorcode
#   screenflick
#   slack
#   transmit
#   appcleaner
#   firefox
#   hazel
#   qlmarkdown
#   seil
#   spotify
#   squidman
#   vagrant
#   arq
#   flash
#   iterm2
#   qlprettypatch
#   shiori
#   sublime-text3
#   virtualbox
#   mailbox
#   qlstephen
#   sketch
#   tower
#   vlc
#   cloudup
#   nvalt
#   quicklook-json
#   skype
#   transmission
# )

# # Apps
# apps=(
#   google-chrome
#   appcleaner
#   firefox
#   seil
#   vagrant
#   flash
#   iterm2
#   shiori
#   sublime-text3
#   virtualbox
#   vlc
#   cloudup
#   nvalt
#   skype
#   transmission
# )
