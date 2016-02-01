#!/bin/bash
set -e

me=$(basename "$0")
active=$1
file=$2
echo "=====Executing[${me}]====="; echo ""
if [ -z "$active" ]; then
  active=$(docker-machine active)
  echo "=====[$active] Docker Machine Name====="; echo ""
fi

if [ -z "$profile" ]; then
  profile="/var/lib/boot2docker/profile"
  echo "=====[$active] [${profile}]====="; echo ""
fi

echo "=====[$active] Profile [$profile]====="; echo ""
docker-machine ssh $active "cat ${profile}"; echo ""
