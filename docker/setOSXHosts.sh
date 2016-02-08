#!/bin/bash
set -e

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
me=$(basename "$0")
active=$1
file=$2

echo "=====Executing[${me}]====="; echo ""
if [ -z "$active" ]; then
  active=$(docker-machine active)
  echo "=====[$active] Docker Machine Name====="; echo ""
fi

if [ -z "$file" ]; then
  file="/etc/hosts"
fi

echo "=====[$active] hosts file [${file}]====="; echo ""
cat $file; echo ""

new_ip="$(docker-machine ip $active)"

# Read from file
# hosts=$(<$SCRIPTS_DIR/conf/OSXHosts)
# map="${new_ip}\t $hosts"

# Read from config
source $SCRIPTS_DIR/conf/docker.private.conf
hosts=$DOTFILES_OSX_HOSTS

map="${new_ip}\t $hosts"

echo "=====[$active] Removing old hosts map====="; echo ""
sudo sed -i.bak "/DONOTREMOVE/d" $file

echo "=====[$active] Adding new hosts map====="; echo ""
echo "=====[$active] New Proxy Host [${new_ip}]====="; echo ""
sudo sed -i -e '$a\'"$map" $file

echo "=====[$active] New hosts file [${file}]====="; echo ""
cat $file; echo ""
