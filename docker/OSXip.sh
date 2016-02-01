#!/bin/bash
set -e
echo $(ifconfig en0 | grep inet\ | awk '{print $2}')
