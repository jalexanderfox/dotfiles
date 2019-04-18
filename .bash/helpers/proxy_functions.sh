#!/bin/bash

#TODO: try using jq for json state management

export PROXY_STATE_PATH="$HOME/.bash/state/"

function proxy() {
  __proxy_check_init $*

  action=${1-"options"}
  shift
  proxy_${action} $*
}

function proxy_options(){
  echo "proxy [custom|init|local|settings|ssh|start|status|vpn]"
  echo "       custom : sets proxy settings point to user defined user:password@host:port"
  echo "       init : sets proxy settings including vpn and ssh"
  echo "       local : sets proxy settings point to localhost:3128"
  echo "       settings : show the terminal environment settings"
  echo "       start : sets proxy settings point to user defined host:3128"
  echo "       status : show the status of the environment and proxy settings"
  echo "       vpn : sets proxy settings for junos pulse, pulse.pac"
  echo ""
  echo "This terminal environment the proxy status is:"
  proxy_status
}

function __proxy_check_init() {
  if [[ $(__proxy_state_get_cache init) == "" ]]
  then
    if [[ "$1" == "" ]]
    then
      _info "Hint: you may want to run 'proxy init' first"
    else
      oops "You may want to run 'proxy init' first"
    fi
  fi
}

function proxy_init() {
  #make sure we have stormssh installed
  brew install stormssh

  local company host port user pass use_host
  company=$(proxy_state_confirm_company)

  host=$(__proxy_state_get_cache "host")
  if [[ -n host ]]
  then
    read -p "Use this proxy host '$host'? (y, n): " use_host
    if [[ "$use_host" != "y" ]] && [[ "$use_host" != "yes" ]]
    then
      read -p "Proxy host or IP (default: localhost): " host
    fi
  fi
  read -p "Port (default: 3128): " port
  read -p "Username (default: ''): " user
  read -p "Password (default: ''): " -s pass &&  echo -e " "
  host=${host:-"localhost"}
  port=${port:-"3128"}

  proxy_run $company $host $port $user $pass
  proxy_vpn -d $company -p $host

  __proxy_state_set_cache init true
}

function __proxy_make_state_dir(){
  mkdir -p "$PROXY_STATE_PATH"
}

function __proxy_state_set(){
cat <<EOF > ${PROXY_STATE_PATH}.proxy
#!/bin/sh
$@
EOF
}

function proxy_stop(){
  proxy_assign ""
  __proxy_state_set ""
  npm config set strict-ssl true

  git config --global --unset http.proxy
  git config --global --unset https.proxy

  npm config rm proxy
  npm config rm https-proxy

  proxy_ssh_stop
  __proxy_state_set_cache state stop
}

function proxy_run(){
  local company=$1
  __proxy_make_state_dir
  __proxy_state_set_cache company "$company"
  __proxy_state_set_cache host "$2"
  __proxy_state_set_cache state run

  if [ -z "${4+x}" ] && [ -z "${5+x}" ]; then
    http_proxy_value="http://$2:$3"
    https_proxy_value="http://$2:$3"
  else
    http_proxy_value="http://$4:$5@$2:$3"
    https_proxy_value="http://$4:$5@$2:$3"
  fi

  # no_proxy_value="localhost,127.0.0.1,192.168/16,169.254/16,10.*,www-local.*,*.local"
  no_proxy_value="$(__my_ip),*.$company,localhost,127.0.0.1,192.168.0.{1..20},172.16.0.0/1,www-local.*,*.local"

  git config --global http.proxy $http_proxy_value
  git config --global https.proxy $https_proxy_value

  npm config set strict-ssl false

  npm config set proxy $http_proxy_value
  npm config set https-proxy $http_proxy_value

  proxy_assign $http_proxy_value $https_proxy_value $no_proxy_value
  proxy_ssh_start $2
}

function proxy_assign(){
  HTTP_PROXY_ENV="http_proxy ftp_proxy all_proxy HTTP_PROXY FTP_PROXY ALL_PROXY typings_proxy"
  HTTPS_PROXY_ENV="https_proxy HTTPS_PROXY"
  NO_PROXY_ENV="no_proxy NO_PROXY"
  for envar in $HTTP_PROXY_ENV
  do
    export $envar=$1
  done
  for envar in $HTTPS_PROXY_ENV
  do
    export $envar=$2
  done
  for envar in $NO_PROXY_ENV
  do
     export $envar=$3
  done

  __proxy_state_set 'proxy_assign' $1 $2 $3
}

function __proxy_state_set_cache(){
cat <<EOF > "${PROXY_STATE_PATH}.proxy.${1}"
$2
EOF
}

function __proxy_state_get_cache(){
  local file
  file="${PROXY_STATE_PATH}.proxy.$1"
  touch "$file"
  value=$(_trim $(cat "$file"))
  echo $value
}

function proxy_state_confirm_company(){
  local company
  company=$(__proxy_state_get_cache "company")
  if [[ -n company ]]
  then
    read -p "Use this company domain '$company'? (y, n): " use_company
    if [[ "$use_company" != "y" ]] && [[ "$use_company" != "yes" ]]
    then
      company=$(proxy_state_require_company)
    fi
  else
    company=$(proxy_state_require_company)
  fi
  echo $company
}

function proxy_state_get_company(){
  local company
  company=$(__proxy_state_get_cache "company")
  if [[ -z "$company" ]]
  then
    company=$(proxy_state_require_company)
  fi
  __proxy_state_set_cache "company" "$company"
  echo $company
}

function proxy_state_require_company(){
  local company
  while [[ -z "$company" ]]; do
    read -p "Company host (ie. company.com): " company
  done
  __proxy_state_set_cache "company" "$company"
  echo $company
}

function proxy_state_confirm_host(){
  host=$(__proxy_state_get_cache "host")
  if [[ -n host ]]
  then
    read -p "Use this proxy host '$host'? (y, n): " use_host
    if [[ "$use_host" != "y" ]] && [[ "$use_host" != "yes" ]]
    then
      host=$(proxy_state_require_host)
    fi
  else
    host=$(proxy_state_require_host)
  fi
  echo $host
}

function proxy_state_get_host(){
  local host
  host=$(__proxy_state_get_cache "host")
  if [[ -z "$host" ]]
  then
    host=$(proxy_state_require_host)
  fi
  echo $host
}

function proxy_state_require_host(){
  local host
  while [[ -z "$host" ]]; do
    read -p "Proxy host/IP (ie. 10.0.0.1): " host
  done
  __proxy_state_set_cache "host" "$host"
  echo $host
}

function proxy_local(){
  company=$(proxy_state_get_company)
  host=localhost
  port=3128

  proxy_run $company $host $port
}

function proxy_start(){
  local company host port
  company=$(__proxy_state_get_cache "company")
  host=$(__proxy_state_get_cache "host")
  if [[ -n host ]]
  then
    read -p "Use this proxy host '$host' (y, n): " use_host
    if [[ "$use_host" != "y" ]] && [[ "$use_host" != "yes" ]]
    then
      read -p "Host or IP: " host
    fi
  fi
 #  read -p "Password: " -s pass &&  echo -e " "
 #  host=proxy.company.com
 #  port=3128
  port=3128

  proxy_run $company $host $port
}

function proxy_custom(){
  company=$(proxy_state_get_company)
  read -p "Username: " user &&  echo -e ""
  read -p "Password: " -s pass &&  echo -e ""
  read -p "Domain: " host &&  echo -e ""
  read -p "Port: " port &&  echo -e ""

  proxy_run $company $host $port $user $pass
}

function proxy_settings(){
  echo ''
  echo "=====[Settings]Shell Proxy====="; echo ''
  if [ -z "${NO_PROXY}" ] && [ -z "${HTTP_PROXY}" ]; then
    echo "=====[INACTIVE]====="; echo ''
  else
    echo "=====[ACTIVE]====="; echo ''
    env | grep -i proxy
  fi
}

function proxy_status(){
 status="inactive"
 proxy_state=$(__proxy_state_get_cache state)
 if [[ -n "$HTTP_PROXY" ]] || [[ "$proxy_state" = "run" ]]
 then
   if [[ "$HTTP_PROXY" = "" ]] || [[ "$proxy_state" = "stop" ]]
   then
     status="dirty"
   else
     status="active"
   fi
 fi
 echo $status
}

_trim() {
    local var="$*"
    var="${var#"${var%%[![:space:]]*}"}"   # remove leading whitespace characters
    var="${var%"${var##*[![:space:]]}"}"   # remove trailing whitespace characters
    echo -n "$var"
}

function proxy_vpn(){
  local OPTIND FLAG HELP NEW_COMPANY_DOMAIN PROXY_HOST

  PULSE_PAC='/Library/Frameworks/pulse.pac'
  OLD_COMPANY_DOMAIN="company.com"

  proxy_vpn_usage() {
    echo "Usage"
    echo "proxy vpn -d [internal host] -p [proxy host name]"
    echo "-d | internal host, likely your company host (ie. company.com)"
    echo "-p | proxy host name or ip (ie. localhost)"
    HELP="help"
  }

  while getopts 'p:d:' FLAG "$@"; do
    case "${FLAG}" in
      d) NEW_COMPANY_DOMAIN="${OPTARG}";;
      p) PROXY_HOST="${OPTARG}";;
      *) proxy_vpn_usage;;
    esac
  done

  echo NEW_COMPANY_DOMAIN
  echo $NEW_COMPANY_DOMAIN
  echo PROXY_HOST
  echo $PROXY_HOST

  if [[ -z "$NEW_COMPANY_DOMAIN" ]] || [[ -z "$PROXY_HOST" ]]
  then
    proxy_vpn_usage
  fi

  # if help, then just exit
  if [[ -n "$HELP" ]]
  then
    return
  fi

  # Shift option index so that $1 now refers to the first argument
  shift $(($OPTIND - 1))

  if [[ -e "$PULSE_PAC" ]]
  then
    echo "file exists: $PULSE_PAC"
    #unlock the file
    sudo chflags nouchg $PULSE_PAC
  fi

  echo "----[OLD pulse.pac]----"
  cat $PULSE_PAC

  echo "creating file: $PULSE_PAC"
  # create pulse.pac
  sudo tee "$PULSE_PAC" > /dev/null <<'EOF'
var proxyHost = "proxy.company.com"
function FindProxyForURL(url, host) {

// If the hostname matches, send direct.
  if (dnsDomainIs(host, "company.com") ||
      shExpMatch(host, "(*.company.com|company.com)"))
      return "DIRECT";

// If the requested website is hosted within the internal network, send direct.
  if (isPlainHostName(host) ||
      shExpMatch(host, "*.local") ||
      isInNet(dnsResolve(host), "10.0.0.0", "255.0.0.0") ||
      isInNet(dnsResolve(host), "172.16.0.0",  "255.240.0.0") ||
      isInNet(dnsResolve(host), "192.168.0.0",  "255.255.0.0") ||
      isInNet(dnsResolve(host), "127.0.0.0", "255.255.255.0"))
      return "DIRECT";

// DEFAULT RULE: All other traffic, use below proxies, in fail-over order.
  return "PROXY "+ proxyHost +":3128";

}
EOF

  echo "Updating pulse.pac"
  sudo gsed -i "s/proxyHost = \"[A-Za-z.]\+\"/proxyHost = \"$PROXY_HOST\"/g" $PULSE_PAC
  sudo gsed -i "s/$OLD_COMPANY_DOMAIN/$NEW_COMPANY_DOMAIN/g" $PULSE_PAC
  echo "----[NEW pulse.pac]----"
  cat $PULSE_PAC

  #lock the file
  sudo chflags uchg $PULSE_PAC
}

proxy_ssh_start() {
  if [[ -z $1 ]]
  then
    oops "must provide a proxy host string as the first argument to this function" "ie. proxy_ssh_start localhost"
    return
  fi

  local host ssh_host ssh_options
  host=$1
  ssh_host="github.com"
  ssh_options="\"${ssh_host}\" ssh.github.com:443 --o \"proxycommand=corkscrew ${host} 3128 %h %p\""

  # echo $(__proxy_ssh_host_exists "$ssh_host")
  if $(__proxy_ssh_host_exists "$ssh_host")
    then
      _info "Editing Host: $ssh_host"
      eval "storm edit $ssh_options"
    else
      _info "Adding Host: $ssh_host"
      eval "storm add $ssh_options"
  fi

  # Host github.com
  #     hostname ssh.github.com
  #     port 443
  #     proxycommand corkscrew 127.0.0.1 3128 %h %p
  return
}

function proxy_ssh_stop() {
  local ssh_host
  ssh_host="github.com"
  _info "Removing SSH Host $ssh_host"
  storm delete "$ssh_host"
}

function __proxy_ssh_host_exists () {
  local ssh_host_found ssh_host_not_found
  ssh_host_found=`storm search "$1"`
  ssh_host_not_found="no results found."
  if [[ $ssh_host_found = $ssh_host_not_found ]]
    then
      # _error_ "ssh host NOT found"
      return 1
    else
      # _info_ "ssh host found"
      return 0
  fi
  return
}


function __my_ip() {
  if [[ "$(uname -s)" = "Darwin" ]]
  then
    my_ip=$(ipconfig getifaddr en0 || ipconfig getifaddr en1)
  else
    my_ip=$(ifconfig eth0|grep inet|head -1|sed 's/\:/ /'|awk '{print $3}')
  fi
  echo $my_ip
}
