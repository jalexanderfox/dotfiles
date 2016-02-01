#! /bin/bash

DIR="$(dirname "$(readlink -f "$0")")"
# SCRIPTS_DIR="${DIR%\/*}"
SCRIPTS_DIR="$1"
ALIAS_FILE="$2"

NO_SLASHES() {
    echo ${1##*/}
}

NO_DOTS() {
    echo ${1%%.*}
}

# ALIAS_MODIFIER="${1##*/}" #basename (last segment in uri)
# ALIAS_FILE_NO_SLASHES=${ALIAS_FILE##*/}
# ALIAS_FILE_NO_DOTS=${ALIAS_FILE_NO_SLASHES%%.*}
ALIAS_MODIFIER=$(NO_DOTS $(NO_SLASHES $2))
cd $DIR

#clear out the ALIAS_FILE
echo '#Docker aliases generated from aliases.sh' > $ALIAS_FILE
for f in $SCRIPTS_DIR/*.sh; do
    [[ -e $f ]] || continue
    file=$(NO_DOTS $(NO_SLASHES $f))
    aliasName="${ALIAS_MODIFIER}_${file}"
    aliasCommand="alias ${aliasName}=${f}"
    echo $aliasCommand >> $ALIAS_FILE
    # eval $aliasCommand
done
