#!/bin/bash
set -e

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
active=$1
profile=$2
if [ -z "$active" ]; then
  active=$(docker-machine active)
  echo "=====[$active] Docker Machine Name====="; echo ""
fi

if [ -z "$profile" ]; then
  profile="/var/lib/boot2docker/profile"
  echo "=====[$active] [${profile}]====="; echo ""
fi

${SCRIPTS_DIR}/setNoProxy.sh $active $profile
${SCRIPTS_DIR}/setProxy.sh $active $profile
${SCRIPTS_DIR}/setOSXHosts.sh $active
${SCRIPTS_DIR}/restartMachine.sh $active
