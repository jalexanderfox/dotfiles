#!/bin/bash

# NOTE: This does not always produce the expected results
# It is often best to just restart the machine

ME=$(basename "$0")
DOCKER_MACHINE_NAME=$1

echo "=====Executing[${me}]====="; echo ""
echo "=====[$DOCKER_MACHINE_NAME] Restarting Docker daemon====="; echo ""
docker-machine ssh $DOCKER_MACHINE_NAME "sudo /etc/init.d/docker restart"; echo ""
