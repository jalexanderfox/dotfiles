#!/bin/bash

actions=("$@")

if [ -z $actions ]; then
  echo "Usage: setup.sh [OPTION]..."
  echo "Setup machine with provided options"
  echo "brew fresh terminal cask osx"; echo ''
  echo "=====[Greetings]====="
  echo "what would you like to setup?"; echo ''; echo ''
  echo "Examples:"; echo ''
  echo "===[setup all]==="; echo ''
  echo "setup.sh brew fresh terminal cask osx"; echo ''
  echo "==[setup a few]=="; echo ''
  echo "setup.sh brew fresh cask"; echo ''
  exit 1
fi

if [[ " ${actions[@]} " =~ " brew " ]]; then
  echo "=====[brew]====="
  # ###############################################################################
  # # BREW
  # ###############################################################################
  ./setup_brew.sh
fi

if [[ " ${actions[@]} " =~ " fresh " ]]; then
  echo "=====[fresh]====="
  # ###############################################################################
  # # FRESH (dotfiles)
  # ###############################################################################
  ./setup_fresh.sh
fi

if [[ " ${actions[@]} " =~ " terminal " ]]; then
  echo "=====[terminal]====="
  # ###############################################################################
  # # TERMINAL COLORS
  # ###############################################################################
  ./setup_terminal_colors.sh
fi

if [[ " ${actions[@]} " =~ " cask " ]]; then
  echo "=====[cask]====="
  # ###############################################################################
  # # BREW CASK
  # ###############################################################################
  ./bash setup_brew_cask.sh
fi

if [[ " ${actions[@]} " =~ " osx " ]]; then
  echo "=====[osx]====="
  # ###############################################################################
  # # OSX DEFAULTS
  # ###############################################################################
  bash setup_osx.sh
fi
