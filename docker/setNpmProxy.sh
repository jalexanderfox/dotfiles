#!/bin/bash
set -e

# strict-ssl=false
# proxy=http://10.9.21.247:3128/
# https-proxy=http://10.9.21.247:3128

SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPTS_DIR/conf/common.sh"
me=$(basename "$0")
color_me=$(green ${me})
active=$1
file=$2

if [ ! -f $PWD/.npmrc ]; then
    message='.npmrc file not found'
    echo $(red "$message")
    echo "Try to rerun $color_me in your directory that has a local .npmrc"
    exit 1
fi

file=$PWD/.npmrc

echo "=====Removing old proxy settings from local .npmrc====="; echo ""
sed -i "/https-proxy/d" ${file}
sed -i "/strict-ssl/d" $file
sed -i "/proxy=/d" $file

new_ip_address=$(${SCRIPTS_DIR}/OSXip.sh)
echo "=====New Proxy Host [$(green $new_ip_address)]====="; echo ""

echo "=====[$(red .npmrc)] Adding new proxy settings from local====="; echo ""
# strict-ssl=false
# proxy=http://10.9.21.247:3128/
# https-proxy=http://10.9.21.247:3128

proxy="http://${new_ip_address}:3128"
sed -i -e "\$astrict-ssl=false" $file
sed -i -e "\$aproxy=${proxy}" $file
sed -i -e "\$ahttps-proxy=${proxy}" $file

echo "=====[$(red .npmrc)] Adding new proxy settings from local .npmrc ====="; echo ""
cat $file
