#!/bin/bash
#
function docker_setEnv {

  if [[ $(docker-machine ls | grep Running | grep $1) ]]; then
    $HOME/.dotfiles/.bash/contexts/actions/docker_setEnv.sh default

    echo "=====docker-machine [$1]====="
    if [[ "$1" == "vpn" ]]; then
      eval "$($HOME/.dotfiles/docker/conf/docker-vpn-env.sh)"
    else
      eval "$(docker-machine env $1)"
    fi

  else
      echo "docker-machine default is not Running"
  fi
}
