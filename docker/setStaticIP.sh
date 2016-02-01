#!/bin/bash
set -e

# !!!EXPERIMENTAL!!!
# This seems to work sometimes however,
# when the daemon is restarted it often reverts to DHCP
SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
DOCKER_MACHINE_NAME=$1
IP=$2
# Test an IP address for validity:
# Usage:
#      valid_ip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#   OR
#      if valid_ip IP_ADDRESS; then echo good; else echo bad; fi
#
function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

function show_example()
{
  echo '============= Like This ============='
  echo '$./setStaticIP.sh [machine-name] [ip]'
  echo '====================================='; echo''
}

if [ -z "$DOCKER_MACHINE_NAME" ] || [ -z "$IP" ]; then
  echo '=====You must provide an ip addresss and docker-machine "name"'; echo ''
  show_example
  exit 1
else
  if ! valid_ip $IP; then
    echo '=====You must provide a valid ip ie.[192.168.99.50]====='; echo ''
    echo "=====You supplied the following IP[$IP]====="; echo ''
    show_example
  else
    CONF="ifconfig eth1 $IP netmask 255.255.255.0 broadcast 192.168.99.255 up"
    echo "=====[$DOCKER_MACHINE_NAME]Adding Static IP[$IP]====="; echo ''
    echo "$CONF"
    echo "$CONF" | docker-machine ssh $DOCKER_MACHINE_NAME sudo tee /var/lib/boot2docker/bootsync.sh > /dev/null
    ${SCRIPTS_DIR}/restartMachine.sh $DOCKER_MACHINE_NAME
  fi
fi
