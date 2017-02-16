#  Fresh Brew Cask Dotfiles

## Introduction
This dotfiles repository utilizes the following:
* [Freshshell (fresh)](https://github.com/freshshell/fresh) to maintain and generate dotfiles

	>*fresh* is a tool to source shell configuration (aliases, functions, etc) from others into your own configuration files. It supports files such as ackrc and gitconfig. Think of it as Bundler for your dot files.

* [Homebrew (brew)](http://brew.sh/) for Mac command line tools automated installation

	>Homebrew installs the stuff you need that Apple didn’t.

* [Homebrew Cask (brew cask)](http://caskroom.io/) for Mac Native Apps automated installation

	>Homebrew Cask extends Homebrew and brings its elegance, simplicity, and speed to OS X applications and large binaries alike. It only takes 1 line in your shell


## Download or Clone
[Freshshell](https://github.com/freshshell/fresh) instructions suggest, installing your dotfiles in '~/.dotfiles'. To download, choose one of the options below.


Download using curl (not git):

```bash
mkdir ~/.dotfiles; curl -#L https://github.com/jalexanderfox/dotfiles/tarball/master | tar -xzv --strip-components 1 -C ~/.dotfiles
```

__OR__

Download using git:

```bash
cd; git clone https://github.com/jalexanderfox/dotfiles.git && mv dotfiles ~/.dotfiles
```

## Installation
There are several options for installing part or all of what comes with this dotfiles repo. If you want to setup a new Mac, you might consider running the [Full Install & Setup](#user-content-full-install--setup) script. If you just need the dotfiles for a vagrant box or a linux environment, then you might consider running just the [Dotfiles (fresh) Install & Setup](#user-content-dotfiles-fresh-install--setup) script.


Now you need to decide whether you want to [Full Install & Setup](#user-content-full-install--setup) or setup individually:
* [Homebrew (brew) formulae](#user-content-homebrew-brew-install--setup)
* [Dotfiles (fresh)](#user-content-dotfiles-fresh-install--setup)
* [Caskroom (brew cask) formulae](#user-content-brew-casks-native-apps--install--setup)
* [terminal colors](#user-content-terminal-colors)
<!-- * [Sensible OS X defaults](#user-content-sensible-os-x-defaults). -->


### Use Caution
As this repository relies heavily on the dotfiles created by others, it attempts to bring the best of theirs into this one but keeps them up to date by using _fresh_. Make sure you know what will be installed, setup and configured before executing these scripts.

### Setup & Install
Now that you have the repo, it's time to setup and install the parts that you want. Install & setup whatever and however you like. Want to install them individually? Go ahead. Want to install them all? You are braver than I am [Full Install](#user-content-full-install--setup). Want to install some? Well you can do that too. Here is how:

#### Suggested Install & Setup
Installs Homebrew(brew), Dotfiles(fresh) and Homebrew Casks (cask)
```bash
cd ~/.dotfiles && ./setup.sh brew fresh cask
```

#### Homebrew (brew) Install & Setup
```bash
cd ~/.dotfiles && ./setup.sh brew
```

#### Dotfiles (fresh) Install & Setup
```bash
cd ~/.dotfiles && ./setup.sh fresh
```

#### Terminal Colors
```bash
cd ~/.dotfiles && ./setup.sh terminal
```

#### Brew Casks (native apps) Install & Setup
```bash
cd ~/.dotfiles && ./setup.sh cask
```

<!--
# DEPRECATED
# use something like this:
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos

#### Sensible OS X defaults (use caution)
When setting up a new Mac, you may want to set some sensible OS X defaults. Use caution when executing this script, it's important to review it first:
```bash
cd ~/.dotfiles && ./setup.sh osx
``` -->

### Full Install & Setup
This script will execute all of the [Individual Install Scripts](#user-content-individual-install-scripts) in the order in which they appear.

```bash
cd ~/.dotfiles && ./setup_all.sh
```

### Extra commands and Private configurations
Add __extra__ custom commands and __private__ configuration without creating a new fork and without committing sensitive information to a public repo.

When running [Dotfiles Fresh Setup](#user-content-dotfiles-fresh-install--setup), if `~/.dotfiles/.extra` and `~/.dotfiles/.private` do not exist, they will be created. You can use these files to add a few custom commands without the need to fork this entire repository and to add commands and configurations that you do not want to commit to a public repository. When ___fresh___ runs, it will source _.extra_ and _.private_ along with the other files. These files get sourced last so they override other configurations.

Example _.extra_ or _.private_ file:

```bash
# Git credentials
# Not in the repository,
# to prevent accidentally committing under the wrong name
GIT_AUTHOR_NAME="Jane Smith"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="janesmith@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

Additionally, fresh will ```touch ~/.gitconfig.local``` which is used by your .gitconfig. You can place custom configurations here ~/.gitconfig.local (which is preferred, otherwise any time you ```fresh``` your global configurations are wiped out.)
```bash
[user]
	name = jared.fox
	email = jared.fox@company.com
[credential]
	helper = osxkeychain
```

__NOTE:__ These files are set to be ignored by git automatically for you.

If you find that your .extra file is getting large, you may want to [fork this repository](https://github.com/jalexanderfox/dotfiles/fork_select) instead.


## Known issues:
* the setup_fresh.sh requires the gnu version of readlink and even if setup_brew.sh is run before setup_fresh.sh, it currently fails on mac because the $PATH does not yet have coreutils (with gnu readlink). The bash_profile can be sourced in the .freshrc as a temporary fix.

## Feedback
Suggestions/improvements
[welcome](https://github.com/jalexanderfox/dotfiles/issues)!

## Thanks to...
* [Tyler Beck](https://github.com/tylerbeck) and his [dotfiles repository](https://github.com/tylerbeck/dotfiles)
* [Jason Weathered](https://github.com/jasoncodes) for [freshshell](https://github.com/freshshell/fresh)
* [Odin Dutton](https://github.com/twe4ked) for [freshshell](https://github.com/freshshell/fresh)
* [Mathias Bynens](http://mathiasbynens.be/) and his [dotfiles repository](https://github.com/mathiasbynens/dotfiles)
* @ptb and [his _OS X Lion Setup_ repository](https://github.com/ptb/Mac-OS-X-Lion-Setup)
* [Ben Alman](http://benalman.com/) and his [dotfiles repository](https://github.com/cowboy/dotfiles)
* [Chris Gerke](http://www.randomsquared.com/) and his [tutorial on creating an OS X SOE master image](http://chris-gerke.blogspot.com/2012/04/mac-osx-soe-master-image-day-7.html) + [_Insta_ repository](https://github.com/cgerke/Insta)
* [Cãtãlin Mariş](https://github.com/alrra) and his [dotfiles repository](https://github.com/alrra/dotfiles)
* [Gianni Chiappetta](http://gf3.ca/) for sharing his [amazing collection of dotfiles](https://github.com/gf3/dotfiles)
* [Jan Moesen](http://jan.moesen.nu/) and his [ancient `.bash_profile`](https://gist.github.com/1156154) + [shiny _tilde_ repository](https://github.com/janmoesen/tilde)
* [Lauri ‘Lri’ Ranta](http://lri.me/) for sharing [loads of hidden preferences](http://lri.me/osx.html#hidden-preferences)
* [Matijs Brinkhuis](http://hotfusion.nl/) and his [dotfiles repository](https://github.com/matijs/dotfiles)
* [Nicolas Gallagher](http://nicolasgallagher.com/) and his [dotfiles repository](https://github.com/necolas/dotfiles)
* [Sindre Sorhus](http://sindresorhus.com/)
* [Tom Ryder](http://blog.sanctum.geek.nz/) and his [dotfiles repository](https://github.com/tejr/dotfiles)

* anyone who [contributed a patch](https://github.com/jalexanderfox/dotfiles/contributors) or [made a helpful suggestion](https://github.com/jalexanderfox/dotfiles/issues)
