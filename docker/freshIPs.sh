#!/bin/bash
set -e

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPTS_DIR/conf/common.sh"

active=$1
profile=$2
if [ -z "$active" ]; then
  active=$(docker-machine active)
  _info_ "[$active] Docker Machine Name"; echo ""
fi

if [ -z "$profile" ]; then
  profile="/var/lib/boot2docker/profile"
  _info_ "[$active] [${profile}]"; echo ""
fi

${SCRIPTS_DIR}/setOSXHosts.sh $active
${SCRIPTS_DIR}/restartMachine.sh $active
