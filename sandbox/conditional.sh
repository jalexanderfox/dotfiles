#!/bin/bash
uname='uname -s'
OS=$($uname)
echo "Host Operating System: $OS"
if [ "$OS" == "Darwin" ]; then
    hostIp=$(ifconfig en0 | grep inet\ | awk '{print $2}')
    echo "Host ip from OS X"
else
    hostIp=${IP_ADDR:-`ip addr | grep 'eth0' -A2 | grep 'inet ' | awk '{print $2}' | cut -f1  -d'/'`}
    echo "Host ip from $OS"
fi
echo $hostIp
