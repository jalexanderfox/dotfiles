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
brew install caskroom/cask/brew-cask
brew tap caskroom/versions


# Install quicklook plugins: https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

# Apps
apps=(
  atom
  controlplane
  dockertoolbox
  firefox
  flash
  google-chrome
  intellij-idea
  iterm2
  java
  optimal-layout
  phantomjs
  squidman
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}
cleanup brew cask and bin files

# Archive... for use if you want
# Apps
# apps=(
#   alfred
#   dropbox
#   google-chrome
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
#   vagrant
#   arq
#   flash
#   iterm2
#   qlprettypatch
#   shiori
#   sublime-text3
#   virtualbox
#   atom
#   flux
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
#   flux
#   vlc
#   cloudup
#   nvalt
#   skype
#   transmission
# )
