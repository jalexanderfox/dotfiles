#!/bin/bash

function proxyF() {
  action=${1-"status"}
  proxy${action^}
}


function proxyStatus() {
  echo "called proxyStatus"
}
