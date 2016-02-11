#! /bin/bash

export RED='\033[31m'         #error
export YELLOW='\033[33m'      #warn
export GREEN='\033[0;32m'     #info
export BLUE='\033[36m'        #log
export INDIGO='\033[0;34m'    #debug
export VIOLET='\033[35m'      #special
export NC='\033[0m'

COLS=$( tput cols )

function color() {
  echo -e "${!2}$1${NC}"
}

# can curry like this too
function red() {
  color "$1" RED
}

function repl() { printf "$1"'%.s' $(eval "echo {1.."$(($2))"}"); }

function _bookend_() {
  _d="[ "
  b_=" ]"
  message="$_d$1$b_"
  message_chars=${#message}
  diff=$(($COLS-$message_chars))

  echo $message$(repl '–' $diff)
}

function _error() {
  echo $(color "$1" RED)
}

function _error_() {
  echo $(_error "$(_bookend_ "$1")")
}

function _warn() {
  echo $(color "$1" YELLOW)
}

function _warn_() {
  echo $(_warn "$(_bookend_ "$1")")
}

function _info() {
  echo $(color "$1" GREEN)
}

function _info_() {
  echo $(_info "$(_bookend_ "$1")")
}

function _debug() {
  echo $(color "$1" BLUE)
}

function _debug_() {
  echo $(_debug "$(_bookend_ "$1")")
}

function _log() {
  echo $(color "$1" VIOLET)
}

function _log_() {
  echo $(_log "$(_bookend_ "$1")")
}

function _special() {
  echo $(color "$1" INDIGO)
}

function _special_() {
  echo $(_special "$(_bookend_ "$1")")
}
