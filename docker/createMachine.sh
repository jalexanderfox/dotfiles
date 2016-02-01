#!/bin/bash

me=$(basename "$0")
echo "=====Executing[${me}]====="; echo ""

MACHINE_NAME=$1
echo "=====[office]Creating docker-machine virtualbox====="; echo ""
docker-machine create --driver=virtualbox --virtualbox-memory=8192 --virtualbox-cpu-count=2 --virtualbox-disk-size=50000 --engine-opt dns=10.1.0.13 $MACHINE_NAME
