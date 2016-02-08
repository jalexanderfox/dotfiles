#!/bin/bash

echo "US/Central - 10:26 PM (CST)" | sed 's/.*\- *\([0-9]\{2\}:[0-9]\{2\}\).*/\1/'
