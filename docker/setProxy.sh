#!/bin/bash
set -e

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPTS_DIR/conf/common.sh"

me=$(basename "$0")
active=$1
file=$2
_info_ "$me"; echo ""
if [ -z "$active" ]; then
  active=$(docker-machine active)
  _info_ "[$active] Docker Machine Name"; echo ""
fi

if [ -z "$profile" ]; then
  profile="/var/lib/boot2docker/profile"
  _info_ "[$active] [${profile}]"; echo ""
fi

_info_ "[$active] Removing old proxy export from docker machine profile"; echo ""
docker-machine ssh $active "sudo sed -i.bak \"/http_proxy/d\" $profile"

new_ip_address=$(${SCRIPTS_DIR}/OSXip.sh)
_info_ "[$active] New Proxy Host [${new_ip_address}]"; echo ""

_info_ "[$active] Adding new proxy export to docker machine profile"; echo ""
docker-machine ssh $active "sudo sed -i.bak -e \"\\\$a\\\export http_proxy=\\\"http://${new_ip_address}:3128\\\"\" ${profile}"

${SCRIPTS_DIR}/profile.sh $active $profile
