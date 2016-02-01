#! /bin/bash

DIR="$(dirname "$(readlink -f "$0")")"
# SCRIPTS_DIR="${DIR%\/*}"
SCRIPTS_DIR='$HOME/.dotfiles/docker'
ALIAS_FILE='$HOME/.dotfiles/state/docker.alias.sh'
cd $DIR

#clear out the ALIAS_FILE
echo '#Docker aliases generated from aliases.sh' > $ALIAS_FILE
for f in ../*.sh; do
    [[ -e $f ]] || continue
    fullFileName=$f
    fileName="${f#*\/}"
    file="${fileName%\.*}"
    aliasName="docker_$file"
    fileAndPath="$SCRIPTS_DIR/$fileName"
    aliasCommand="alias $aliasName='$fileAndPath'"
    echo $aliasCommand >> $ALIAS_FILE
    # eval $aliasCommand
done
