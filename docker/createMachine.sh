#!/bin/bash

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPTS_DIR/conf/common.sh"

me=$(basename "$0")
_info_ "Executing[$me]"; echo ""

MACHINE_NAME=$1
_info_ "[office]Creating docker-machine virtualbox"; echo ""
docker-machine create --driver=virtualbox --virtualbox-memory=8192 --virtualbox-cpu-count=2 --virtualbox-disk-size=50000 --engine-opt dns=10.1.0.13 $MACHINE_NAME
