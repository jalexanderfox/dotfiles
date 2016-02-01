#!/bin/bash

#/test/something/test2
#should echo test2
echo ${1##*/}
