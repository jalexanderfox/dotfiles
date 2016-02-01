#!/bin/bash

ME=$(basename "$0")

echo "=====Executing[${ME}]====="; echo ""
echo "=====Executing[${me}]====="; echo ""
echo "=====[${1}] Restarting Docker Machine====="; echo ""
docker-machine restart ${1}; echo ""
