#!/bin/bash

proxycmd=$'#!/bin/sh\nproxy_stop\n'
echo "$proxycmd" > ~/.bash/state/.proxy
