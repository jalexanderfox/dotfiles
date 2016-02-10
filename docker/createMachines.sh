#!/bin/bash

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPTS_DIR/conf/common.sh"

me=$(basename "$0")
_info_ "Executing[$me]"; echo ""

DOCKER_MACHINE_NAME="office"
_info_ "[$DOCKER_MACHINE_NAME] Creating docker-machine virtualbox"; echo ''
${SCRIPTS_DIR}/createMachine.sh $DOCKER_MACHINE_NAME

DOCKER_MACHINE_NAME="vpn"
_info_ "[$DOCKER_MACHINE_NAME] Creating docker-machine virtualbox"; echo ''
${SCRIPTS_DIR}/createMachine.sh $DOCKER_MACHINE_NAME
