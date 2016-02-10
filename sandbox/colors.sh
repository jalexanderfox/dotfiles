#!/bin/bash

DIR="$(dirname "$(readlink -f "$0")")"
SCRIPTS_DIR="$DIR"

source "$SCRIPTS_DIR/../docker/conf/common.sh"

_error "error message"
_error_ "error with bookends"

_warn "warn message"; _warn
_warn_ "warn with bookends"

_info "info message"
_info_ "info with bookends"

_debug "debug message"
_debug_ "debug with bookends"

_log "log message"
_log_ "log with bookends"

_special "special"
_special_ "special with bookends"
