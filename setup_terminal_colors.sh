###############################################################################
# COLORS
###############################################################################

# setup terminal and iterm colors with solarized
# solarized or alternative: # https://gist.github.com/kraft001/2893831
mkdir -p ~/.dotfiles/lib
cd ~/.dotfiles/lib
git clone https://github.com/altercation/solarized.git
cd ~/.dotfiles

###############################################################################
# TERMINAL
###############################################################################

# adds themes to terminal
open ~/.dotfiles/lib/solarized/osx-terminal.app-colors-solarized/'Solarized Light ansi.terminal'
open ~/.dotfiles/lib/solarized/osx-terminal.app-colors-solarized/'Solarized Dark ansi.terminal'

# set Terminal default theme to "Solarized Dark ansi"
COLOR_THEME="Solarized Dark ansi"
defaults write com.apple.Terminal "Default Window Settings" -string $COLOR_THEME
defaults write com.apple.Terminal "Startup Window Settings" -string $COLOR_THEME

###############################################################################
# ITERM2
###############################################################################

# adds themes to iterm2
open ~/.dotfiles/lib/solarized/iterm2-colors-solarized/'Solarized Light.itermcolors'
open ~/.dotfiles/lib/solarized/iterm2-colors-solarized/'Solarized Dark.itermcolors'


###############################################################################
# VIM
###############################################################################
# this is being set by .freshrc VIM section

# # add theme to vim -- this doesn't seem to work on mac
# mkdir -p ~/.vim/colors
# cp ~/.dotfiles/lib/solarized/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/

# # solarized other terminal apps ie. tmux, vim
# # store all solarized files in one place
# mkdir -p ~/.dotfiles/.solarized
# SOLARIZED=~/.dotfiles/.solarized
# cd $SOLARIZED

# # http://www.webupd8.org/2011/04/solarized-must-have-color-paletter-for.html
# git clone https://github.com/seebi/dircolors-solarized.git
# eval `dircolors $SOLARIZED/dircolors-solarized/dircolors.256dark`
# ln -s $SOLARIZED/dircolors-solarized/dircolors.256dark ~/.dir_colors

# git clone https://github.com/seebi/tmux-colors-solarized.git
# echo "
# set -g default-terminal \"screen-256color-bce\"
# source ~/.dotfiles/.solarized/tmux-colors-solarized/tmuxcolors.conf" >> ~/.tmux.conf


# # this doesn't seem to work on mac
# echo "
# set term=screen-256color-bce
# let g:solarized_termcolors=256
# set t_Co=256
# set background=dark
# colorscheme default " >> ~/.vimrc.after

# Restart the terminal
open ./restart-terminal.app
