#!/bin/bash

DIR="$(dirname "$(readlink -f "$0")")"
SCRIPTS_DIR="$DIR"

source "$SCRIPTS_DIR/common.sh"

_error "Error Message"
_error_ "Error with Bookends"; echo

_warn "Warn Message";
_warn_ "Warn with Bookends"; echo

_info "Info Message"
_info_ "Info with Bookends"; echo

_debug "Debug Message"
_debug_ "Debug with Bookends"; echo

_log "Log Message"
_log_ "Log with Bookends"; echo

_special "Special Message"
_special_ "Special with Bookends"; echo
