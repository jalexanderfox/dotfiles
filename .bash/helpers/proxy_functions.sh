#!/bin/bash
function proxy() {
  action=${1-"status"}
  proxy_${action}
}

function _proxy_assign(){
  HTTP_PROXY_ENV="http_proxy ftp_proxy all_proxy HTTP_PROXY FTP_PROXY ALL_PROXY typings_proxy"
  HTTPS_PROXY_ENV="https_proxy HTTPS_PROXY"
  for envar in $HTTP_PROXY_ENV
  do
    export $envar=$1
  done
  for envar in $HTTPS_PROXY_ENV
  do
    export $envar=$2
  done
  for envar in "no_proxy NO_PROXY"
  do
     export $envar=$3
  done
}

function proxy_stop(){
  _proxy_assign ""
  npm config set strict-ssl true
  apm config set strict-ssl true

  git config --global --unset http.proxy
  git config --global --unset https.proxy

  npm config rm proxy
  npm config rm https-proxy

  apm config rm proxy
  apm config rm https-proxy
}

function _proxy_init(){
  if [ -z "${3+x}" ] && [ -z "${4+x}" ]; then
    http_proxy_value="http://$1:$2"
    https_proxy_value="https://$1:$2"
  else
    http_proxy_value="http://$3:$4@$1:$2"
    https_proxy_value="https://$3:$4@$1:$2"
  fi

  no_proxy_value="127.0.0.1,localhost,192.168.99.100,192.168.99.101,192.168.99.102,192.168.99.103,192.168.99.104,192.168.99.105,,192.168.99.106,169.254/16,192.168/16,www-local.*,*.local"

  git config --global http.proxy $http_proxy_value
  git config --global https.proxy $https_proxy_value

  npm config set strict-ssl false
  apm config set strict-ssl false

  npm config set proxy $http_proxy_value
  npm config set https-proxy $http_proxy_value

  apm config set proxy $http_proxy_value
  apm config set http-proxy $http_proxy_value
  apm config set https-proxy $http_proxy_value

  _proxy_assign $http_proxy_value $https_proxy_value $no_proxy_value
}

function proxy_start(){
 #  read -p "Username: " -s user
 #  read -p "Password: " -s pass &&  echo -e " "
 #  domain=proxy.company.com
 #  port=3128
  domain=localhost
  port=3128

  _proxy_init $domain $port
}

function proxy_custom(){
  read -p "Username: " user &&  echo -e ""
  read -p "Password: " -s pass &&  echo -e ""
  read -p "Domain: " domain &&  echo -e ""
  read -p "Port: " port &&  echo -e ""

  _proxy_init $domain $port $user $pass
}

function proxy_settings(){
  echo ''
  echo "=====[Settings]Shell Proxy====="; echo ''
  if [ -z "${NO_PROXY}" ] && [ -z "${HTTP_PROXY}" ]; then
    echo "=====[INACTIVE]====="; echo ''
  else
    echo "=====[ACTIVE]====="; echo ''
    echo "\$NO_PROXY="
    echo $NO_PROXY; echo ''
    echo "\$HTTP_PROXY="
    echo $HTTP_PROXY; echo ''
  fi
}

function proxy_status(){
 status="inactive"
 currentProxyCmd="$(cat ~/.bash/state/.proxy | grep proxy)"
 if [ -n "$HTTP_PROXY" ] ||
     [ "$currentProxyCmd" = "proxy_start" ]; then
   if [ "$HTTP_PROXY" = "" ] ||
       [ "$currentProxyCmd" = "proxy_stop" ]; then
        status="dirty"
   else
     status="active"
   fi
 fi
 echo $status
}
