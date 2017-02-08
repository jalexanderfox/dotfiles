#! /bin/bash

export RED='\033[31m'         #error
export YELLOW='\033[33m'      #warn
export GREEN='\033[0;32m'     #info
export BLUE='\033[36m'        #log
export INDIGO='\033[0;34m'    #debug
export VIOLET='\033[35m'      #special
export NC='\033[0m'

color() {
  echo -e "${!1}${@:2}${NC}"
}

color_cat() {
  echo -e "${!1}"
  cat ${@:2}
  echo -e "${NC}"
}

# can curry like this too
red() {
  color RED "$@"
}

repl() { printf "$1"'%.s' $(eval "echo {1.."$(($2))"}"); }

_bookend_() {
  COLS=$( tput cols )

  _d="[ "
  b_=" ]"
  message="$_d$@$b_"
  message_chars=${#message}
  diff=$(($COLS-$message_chars))

  echo $message$(repl '–' $diff)
}

_error() {
  echo $(color RED "$@")
}

_error_() {
  echo $(_error "$(_bookend_ "$@")")
}

to_error () {
  while read -r line; do _error "$line"; done
}

to_cat_error () {
  color_cat RED "$@"
}

to_cat_special () {
  color_cat VIOLET "$@"
}

_warn() {
  echo $(color YELLOW "$@")
}

_warn_() {
  echo $(_warn "$(_bookend_ "$@")")
}

to_warn () {
  while read -r line; do _warn $line; done
}

_info() {
  echo $(color GREEN "$@")
}

_info_() {
  echo $(_info "$(_bookend_ "$@")")
}

to_info () {
  while read -r line; do _info $line; done
}

_debug() {
  echo $(color INDIGO "$@")
}

_debug_() {
  echo $(_debug "$(_bookend_ "$@")")
}

to_debug () {
  while read -r line; do _debug $line; done
}

_log() {
  echo $(color BLUE "$@")
}

_log_() {
  echo $(_log "$(_bookend_ "$1")")
}

to_log () {
  while read -r line; do _log $line; done
}

_special() {
  echo $(color VIOLET "$@")
}

_special_() {
  echo $(_special "$(_bookend_ "$1")")
}

to_special () {
  while read -r line; do _special $line; done
}
