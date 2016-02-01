#! /bin/bash

DIR="$(dirname "$(readlink -f "$0")")"
SCRIPTS_DIR="$DIR"

NO_SLASHES() {
    echo ${1##*/}
}

NO_DOTS() {
    echo ${1%%.*}
}

ALIAS_MODIFIER=$(NO_SLASHES $SCRIPTS_DIR)
cd $DIR

#clear out the ALIAS_FILE
echo '=====[aliases]====='
for f in $SCRIPTS_DIR/*.sh; do
    [[ -e $f ]] || continue
    file=$(NO_DOTS $(NO_SLASHES $f))
    aliasName="${ALIAS_MODIFIER}_${file}"
    aliasCommand="${aliasName}"
    echo $aliasCommand
done
echo "=====[scripts location]====="
echo "$SCRIPTS_DIR"
