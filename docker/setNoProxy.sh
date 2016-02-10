#!/bin/bash
set -e

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
me=$(basename "$0")
active=$1
file=$2

echo "=====Executing[$me]====="; echo ""
if [ -z "$active" ]; then
  active=$(docker-machine active)
  echo "=====[$active] Docker Machine Name====="; echo ""
fi

if [ -z "$profile" ]; then
  profile="/var/lib/boot2docker/profile"
  echo "=====[$active] [${profile}]====="; echo ""
fi

echo "=====[$active] Removing old no_proxy export from docker machine profile====="; echo ""
docker-machine ssh $active "sudo sed -i.bak \"/no_proxy/d\" $profile"

# Read from file
# no_proxy="$(<$SCRIPTS_DIR/conf/noProxy)"

# Use config
source $SCRIPTS_DIR/conf/docker.private.conf
no_proxy=$DOTFILES_DOCKER_NO_PROXY

echo "=====[$active] no_proxy Hosts [${no_proxy}]====="; echo ""

echo "=====[$active] Adding new no_proxy export to docker machine profile====="; echo ""
docker-machine ssh $active "sudo sed -i.bak -e \"\\\$a\\\export no_proxy=\\\"${no_proxy}\\\"\" ${profile}"

${SCRIPTS_DIR}/profile.sh $active $profile
