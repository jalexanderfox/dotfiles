#!/bin/bash

#
# In Bash (and ksh, zsh, dash, etc.), you can use parameter expansion
# with % which will remove characters from the end of the string
# or # which will remove characters from the beginning of the string.
# If you use a single one of those characters, the smallest matching
# string will be removed. If you double the character, the longest will be removed.


NO_SLASHES() {
    echo ${1##*/}
}

NO_DOTS() {
    echo ${1%%.*}
}


echo 'test'
noSlashes=${1##*/}
echo "noSlashes = $noSlashes"
noDots=${noSlashes%%.*}
echo "noDots = $noDots";echo '----';

noSlashNoDot=$(NO_DOTS $(NO_SLASHES $1))
echo "noSlashNoDot = $noSlashNoDot"; echo '----';

a='hello:world'
b=${a%:*}
echo "$b"
echo "hello"
a='hello:world:of:tomorrow'
echo "${a%:*}"
echo "hello:world:of"
echo "${a%%:*}"
echo "hello"
echo "${a#*:}"
echo "world:of:tomorrow"
