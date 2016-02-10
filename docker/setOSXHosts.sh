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

if [ -z "$file" ]; then
  file="/etc/hosts"
fi

_info_ "[$active] hosts file [${file}]"; echo ""
cat $file; echo ""

new_ip="$(docker-machine ip $active)"

# Read from file
# hosts=$(<$SCRIPTS_DIR/conf/OSXHosts)
# map="${new_ip}\t $hosts"

# Read from config
source $SCRIPTS_DIR/conf/docker.private.conf
hosts=$DOTFILES_OSX_HOSTS

map="${new_ip}\t $hosts"

_info_ "[$active] Removing old hosts map"; echo ""
sudo sed -i.bak "/DONOTREMOVE/d" $file

_info_ "[$active] Adding new hosts map"; echo ""
_info_ "[$active] New Proxy Host [${new_ip}]"; echo ""
sudo sed -i -e '$a\'"$map" $file

_info_ "[$active] New hosts file [${file}]"; echo ""
cat $file; echo ""
