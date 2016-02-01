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

proxy_host="$(docker-machine ssh ${active} "grep http_proxy ${profile}"  | awk -F \" '{print $2}' | awk -F \/ '{print $3}' | awk -F : '{print $1}')"
echo "=====[$active] Proxy Host [$proxy_host]====="; echo ""
