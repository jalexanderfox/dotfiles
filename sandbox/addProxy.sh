#!/bin/bash

sh ./unsetProxy.sh


#add http_proxy to end of file
echo '***************ADD PROXY CONFIG****************'
new_ip_address=$(ifconfig en0 | grep inet\ | awk '{print $2}')
proxy_string="export http_proxy=http://$new_ip_address:3128"
echo $proxy_string
sed -i.bak -e "\$a\\$proxy_string" profile
# sed "$a|\\n$proxy_string"
echo ''
echo '_______________profile_______________'
cat profile
echo ''
echo '_______________profile.bak_______________'
cat profile.bak
