#!/bin/bash
# custom files that do not get committed into the repo
custom=('.extra' '.private' 'conf/.gitconfig.local')
for i in "${custom[@]}"
do
	if [ -f $i ]
	  then
	    echo "$i exists."
	  else
	    echo "creating $i file"
	    touch $i
	    echo '# this file is for custom and private configurations, it does not get committed to the repo' >> $i
	fi
done


# Get fresh, freshshell
bash -c "`curl -sL get.freshshell.com`"

#add freshshell
source ~/.fresh/build/shell.sh

# link (symbolic + If the target file already exists, then unlink it so that the link may occur.)
# ~/.dotfiles/.freshrc ~/.freshrc
#
# read about it in the .freshrc or in the README.md
ln -sf  ~/.dotfiles/.freshrc ~/.freshrc
fresh


# symbolic link to the ~/.fresh directory for debugging source/build of the fresh dotfiles
# ln -sf ~/.fresh ~/.dotfiles/.fresh
