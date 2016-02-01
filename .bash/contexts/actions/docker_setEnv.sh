#!/bin/bash

dockerenv="docker_setEnv $1"
echo "$dockerenv" > ~/.bash/state/.docker-env
