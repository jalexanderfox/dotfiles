#! /bin/bash

export BLUE='\033[0;34m'
export GREEN='\033[0;32m'
export RED='\033[31m'
export NC='\033[0m'

function color() {
  echo -e "${!2}""$1"${NC}
}

function green() {
  color "$1" GREEN
}

function red() {
  color "$1" RED
}
