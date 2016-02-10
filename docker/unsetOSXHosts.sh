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

_info_ "[$active] Removing old hosts map"; echo ""
sudo sed -i.bak "/DONOTREMOVE/d" $file

_info_ "[$active] New hosts file [${file}]"; echo ""
cat $file; echo ""
