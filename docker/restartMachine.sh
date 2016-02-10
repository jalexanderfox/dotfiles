#!/bin/bash

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPTS_DIR/conf/common.sh"
me=$(basename "$0")

_info_ "Executing[$me]"; echo ""
_info_ "[${1}] Restarting Docker Machine"; echo ""
docker-machine restart ${1}; echo ""
