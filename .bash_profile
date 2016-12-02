#GET BASE PATH- ---------------------------------
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done

export DOTFILES="$(dirname "$SOURCE")"

#INCLUDED SOURCES -------------------------------

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"
export LC_CTYPE="en_US.UTF-8"

#setup mac to use /usr/local/
PATH="/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin/:$PATH"
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export SVN_EDITOR=vim

#GoLang path
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# this is handled by freshshell
# Add `~/bin` to the `$PATH`
# export PATH="$HOME/bin:$PATH"

source ~/.bash/state/.fresh-user
###############################################################################
#add freshshell
source ~/.fresh/build/shell.sh

###############################################################################
source ~/.bash/state/.proxy


# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.
# * ~/.private can be used for other settings you don’t want to commit.
#for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,private}; do
for file in ~/.{exports,aliases,functions,extra,private}; do
	[ -r "$file" ] && source "$file"
done
unset file
umask 002

#setup z.sh jumper
. `brew --prefix`/etc/profile.d/z.sh




# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
#shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# load up the aliases and functions from .bashrc
# if [ -f ~/.bashrc ]; then . ~/.bashrc ; fi
# - doing the opposite now, loading all from .bash_profile into .bashrc


# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done


###############################################################################
# COMPLETION
###############################################################################

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
  complete -o default -W "$(cat ~/.ssh/known_hosts | sed 's/[, ].*//' | sort | uniq | grep -v '[0-9]')" ssh scp stfp
fi

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

###############################################################################
#RUBY
###############################################################################

# http://michaelahale.com/blog/2008/11/20/rubyopt-how-it-works/
export RUBYOPT="-r rubygems"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

###############################################################################
# NVM
###############################################################################

# export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh

###############################################################################
# APM
###############################################################################

# export ATOM_NODE_URL=http://gh-contractor-zcbenz.s3.amazonaws.com/atom-shell/dist
