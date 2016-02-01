#!/bin/bash
#
function docker_setEnv {
  echo "=====docker-machine [$1]====="
  if [[ "$1" == "vpn" ]]; then
    eval "$($HOME/.dotfiles/docker/conf/docker-vpn-env.sh)"
  else
    eval "$(docker-machine env $1)"
  fi
}
