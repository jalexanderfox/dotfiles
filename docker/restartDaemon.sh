#!/bin/bash

# NOTE: This does not always produce the expected results
# It is often best to just restart the machine

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPTS_DIR/conf/common.sh"

ME=$(basename "$0")
DOCKER_MACHINE_NAME=$1

_info_ "Executing[$me]"; echo ""
_info_ "[$DOCKER_MACHINE_NAME] Restarting Docker daemon"; echo ""
docker-machine ssh $DOCKER_MACHINE_NAME "sudo /etc/init.d/docker restart"; echo ""
