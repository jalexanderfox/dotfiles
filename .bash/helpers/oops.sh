#!/bin/bash

function oops() {
  _error_ 'OOPS:'
  while [[ -n "$1" ]]; do
    _error "$1"
    shift
  done
  _error
  return 0
}
