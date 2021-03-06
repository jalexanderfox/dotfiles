#!/usr/bin/env bash

# reference: http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

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


# Update homebrew recipes
brew update

# Upgrade any already-installed formulae.
brew upgrade


###############################################################################
# Install GNU core utilities
# (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum


# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed` -> `gsed`, overwriting the built-in `sed`.
brew install gnu-sed

# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions

brew install bash-completion2

# Install `wget` with IRI support.
brew install wget

# Install more recent versions of some OS X tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install screen
# brew install homebrew/php/php55 --with-gmp


###############################################################################
# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2


# Install RingoJS and Narwhal.
# Note that the order in which these are installed is important;
# see http://git.io/brew-narwhal-ringo.
# brew install ringojs
# brew install narwhal


# List of binaries to install
# sshfs
binaries=(
  ack
  bat
  ffmpeg
  graphicsmagick
  httpie
  hub
  iproute2mac
  jq
  git
  git-lfs
  n
  node
  prettyping
  python
  rg
  rename
  stormssh
  trash
  tree
  webkit2png
  zopfli
)

echo "installing binaries..."
brew install ${binaries[@]}

# Install other useful binaries.
# brew install ack # installed above
# brew install dark-mode
#brew install exiv2
brew install imagemagick --with-webp
# brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
# brew install rhino
brew install speedtest_cli
brew install ssh-copy-id
# Install Z
# dont forget this in your .bash_profile
# . `brew --prefix`/etc/profile.d/z.sh
brew install z


###############################################################################
# Install some CTF tools; see https://github.com/ctfs/write-ups.
# brew install aircrack-ng
# brew install bfg
# brew install binutils
# brew install binwalk
# brew install cifer
# brew install dex2jar
# brew install dns2tcp
# brew install fcrackzip
# brew install foremost
# brew install hashpump
# brew install hydra
# brew install john
# brew install knock
# brew install netpbm
# brew install nmap
# brew install pngcheck
# brew install socat
# brew install sqlmap
# brew install tcpflow
# brew install tcpreplay
# brew install tcptrace
# brew install ucspi-tcp # `tcpserver` etc.
# brew install xpdf
# brew install xz

# nvm caveats
# NVM's working directory to your $HOME path (if it doesn't exist):
#mkdir ~/.nvm

#Copy nvm-exec to NVM's working directory
#cp $(brew --prefix nvm)/nvm-exec ~/.nvm/

###############################################################################
# Cleanup
# After you're done, you should clean everything up with:
brew cleanup
