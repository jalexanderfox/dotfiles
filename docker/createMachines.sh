#!/bin/bash

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
me=$(basename "$0")
echo "=====Executing[${me}]====="; echo ""

DOCKER_MACHINE_NAME="office"
echo "=====[$DOCKER_MACHINE_NAME] Creating docker-machine virtualbox====="; echo ''
${SCRIPTS_DIR}/createMachine.sh $DOCKER_MACHINE_NAME

DOCKER_MACHINE_NAME="vpn"
echo "=====[$DOCKER_MACHINE_NAME] Creating docker-machine virtualbox====="; echo ''
${SCRIPTS_DIR}/createMachine.sh $DOCKER_MACHINE_NAME
