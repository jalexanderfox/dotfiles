#! /bin/bash

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPTS_DIR/conf/common.sh"

NO_SLASHES() {
    echo ${1##*/}
}

NO_DOTS() {
    echo ${1%%.*}
}

ALIAS_MODIFIER=$(NO_SLASHES $SCRIPTS_DIR)
cd $SCRIPTS_DIR

#clear out the ALIAS_FILE
_info_ 'aliases'
for f in $SCRIPTS_DIR/*.sh; do
    [[ -e $f ]] || continue
    file=$(NO_DOTS $(NO_SLASHES $f))
    aliasName="${ALIAS_MODIFIER}_${file}"
    aliasCommand="${aliasName}"
    _log $aliasCommand
done
_info_ 'scripts location'
_special "$SCRIPTS_DIR"
