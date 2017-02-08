#!/bin/bash
function most() (
  local DIR=$(pwd)
  local DRY=""
  local CLEAN=""
  local HOSTS_FILE="/etc/hosts"
  local SSH_CONFIG_FILE="$HOME/.ssh/config"
  local HOST_NAME=""
  local IP=""
  local USER=$(whoami)
  local SILENT=''

  __sh () {
    _debug "\$ $1"
    _L
    if [ -z "$DRY" ] && [ -z "$2" ]
      then
        eval "$1"
    fi
  }

  _L () {
    echo ""
  }

  __MOST_SHOW_USAGE () {
    _info_ "Usage:"
    _info_ "most [-hdks] [-a alias] [-c clean] [-f host file] [-i ip(required)] [-n host name(required)] [-u user]"
    _info "   -a | alias -- ssh host alias"
    _info "   -c | clean/remove host map"
    _info "   -d | dry run"
    _info "   -f | hosts file"
    _info "   -h | help"
    _info "   -i | IP to map the host name to"
    _info "   -k | place id_rsa.pub key on host"
    _info "   -n | host name to map the IP to"
    _info "   -u | 'user' name for host"
    _info "   -s | silent"

    MOST_USAGE_SHOWN='true'
  }

  local OPTIND FLAG

  while getopts 'cdhksa:f:n:i:u:' FLAG; do
    case "${FLAG}" in
      a) ALIAS="${OPTARG}";;
      c) CLEAN="true";;
      d) DRY='true' ;;
      f) HOSTS_FILE="${OPTARG}";;
      i) IP="${OPTARG}";;
      k) KEYS="true";;
      n) HOST_NAME="${OPTARG}";;
      u) USER="${OPTARG}";;
      s) SILENT="true" ;;
      *) oops "Unexpected option ${FLAG}"; __MOST_SHOW_USAGE;;
    esac
  done
  shift $(($OPTIND - 1))


  if [[ -n "$SILENT" ]]
    then
      eval "cat () { return 0; }"
      eval "echo () { return 0; }"
  fi

  if [[ -z "$HOST_NAME" ]]
    then
      oops 'Must provide host name via the "-n" flag:' \
           'most -n myhost -i 192.168.0.10'
      __MOST_SHOW_USAGE
      return
  fi

  if [[ -z "$IP"  ]] && [[ -z "$CLEAN" ]]
    then
      oops 'Must provide ip via the "-i" flag:' \
           'most -n myhost -i 192.168.0.10'
      __MOST_SHOW_USAGE
      return
  fi

  __HOSTS_REMOVE_HOST () {
    _warn_ "Removing old hosts map"; _L
    # sudo sed -i.bak "/${HOST_NAME}/d" ${HOSTS_FILE}
    __sh "sudo sed -i.bak \"/${HOST_NAME}/d\" ${HOSTS_FILE}"
    return
  }

  __HOSTS_ADD_HOST () {
    _info_ "Adding new hosts map"; _L
    _info "New Host [$HOST_NAME] -> [${IP}]"; _L
    # sudo sed -i -e '$a\'"$MAP" $HOSTS_FILE
    __sh "sudo sed -i -e '\$a\'\"$MAP\" $HOSTS_FILE"
    return
  }

  _SSH_HOST_EXISTS () {
    SSH_HOST_FOUND=`storm search '$(_GET_SSH_HOST_NAME)'`
    SSH_HOST_NOT_FOUND="no results found."
    if [[ $SSH_HOST_FOUND = $SSH_HOST_NOT_FOUND ]]
      then
        _error_ "SSH HOST NOT FOUND"
        return 1
      else
        _info_ "ssh host found"
        return 0
    fi
    return
  }

  _GET_SSH_HOST_NAME () {
    if [[ -z "$ALIAS" ]]
      then
        echo "${HOST_NAME}"
      else
        echo "${HOST_NAME} ${ALIAS}"
    fi
    return
  }

  __SSH_REMOVE_HOST () {
    _warn_ "Remove Host from ssh config"; _L
    _warn "Host[${HOST_NAME}]"
    _warn "ssh config[$SSH_CONFIG_FILE]"; _L
    __sh "storm delete '$(_GET_SSH_HOST_NAME)'"
    return
  }

  __SSH_ADD_UDATE_HOST () {
    _info_ "Add or Update Host in ssh config[$SSH_CONFIG_FILE]";
    _info "Host[${HOST_NAME}] Alias[${ALIAS}]"
    _info "ssh config[$SSH_CONFIG_FILE]"; _L

    SSH_OPTIONS="'$(_GET_SSH_HOST_NAME)' ${USER}@${IP}"

    echo ${_SSH_HOST_EXISTS}
    if _SSH_HOST_EXISTS
      then
        _info "Editing Host"
        __sh "storm edit ${SSH_OPTIONS}"
      else
        _info "Adding Host"
        __sh "storm add ${SSH_OPTIONS}"
    fi
    return
  }

  #
  #HOSTS_FILE UPDATE | BEGIN
  #
  _info_ "Update \"$HOSTS_FILE\""
  cat $HOSTS_FILE; _L

  MAP="${IP}\t $HOST_NAME"

  __HOSTS_REMOVE_HOST

  if [[ -z "$CLEAN" ]]
    then
      __HOSTS_ADD_HOST
  fi

  _info_ "New Hosts file [${HOSTS_FILE}]"; _L
  cat $HOSTS_FILE | to_debug; _L
  #
  #HOSTS_FILE UPDATE | END
  #


  #
  #SSH_CONFIG_FILE UPDATE | BEGIN
  #
  _info_ "Update ssh config [$SSH_CONFIG_FILE]"; _L
  cat "$SSH_CONFIG_FILE"; _L
  if [[ -z "$CLEAN" ]]
    then
      __SSH_ADD_UDATE_HOST
    else
      __SSH_REMOVE_HOST
  fi
  _info_ "New ssh config [$SSH_CONFIG_FILE]"; _L
  cat $SSH_CONFIG_FILE | to_info; _L
  #
  #SSH_CONFIG_FILE UPDATE | END
  #


  #
  #ADD SSH KEYS TO THE HOST | BEGIN
  #

  if [[ -n "$KEYS" ]]
    then
      SSH_ID_RSA_PUB="$(hostname)_id_rsa.pub";
      # __sh "ssh $HOST_NAME 'mkdir ~/.ssh'; cat ~/.ssh/id_rsa.pub | ssh $HOST_NAME 'cat >> .ssh/authorized_keys'"
      __sh "cat ~/.ssh/id_rsa.pub \
          | ssh $HOST_NAME \
            'cat >> $SSH_ID_RSA_PUB; \
            mkdir .ssh; \
            cat $SSH_ID_RSA_PUB >> .ssh/authorized_keys; \
            mv $SSH_ID_RSA_PUB .ssh/'"
  fi
  #
  #ADD SSH KEYS TO THE HOST | END
  #

  return
)
