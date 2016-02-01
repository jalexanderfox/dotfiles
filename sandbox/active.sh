#!/bin/bash
active=$1
if [ -z "$active" ]; then
  echo "\$docker-machine active"
  active=$(docker-machine active)
  echo "Active Docker Machine == $active"
else
  echo "Selected Docker Machine == $active"
fi
