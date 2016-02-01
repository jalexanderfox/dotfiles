#!/bin/bash

#delete http_proxy
echo '***************REMOVE PROXY CONFIG****************'

sed -i.bak '/export http_proxy/d' profile

echo ''
echo '_______________profile_______________'
cat profile
echo ''
echo '_______________profile.bak_______________'
cat profile.bak
