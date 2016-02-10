#!/bin/bash
set -e

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPTS_DIR/conf/common.sh"

me=$(basename "$0")
active=$1
file=$2
_info_ "Executing[$me]"; echo ""
if [ -z "$active" ]; then
  active=$(docker-machine active)
  _info_ "[$active] Docker Machine Name"; echo ""
fi

if [ -z "$profile" ]; then
  profile="/var/lib/boot2docker/profile"
  _info_ "[$active] [${profile}]"; echo ""
fi

proxy_host="$(docker-machine ssh ${active} "grep http_proxy ${profile}"  | awk -F \" '{print $2}' | awk -F \/ '{print $3}' | awk -F : '{print $1}')"
_info_ "[$active] Proxy Host [$proxy_host]"; echo ""
