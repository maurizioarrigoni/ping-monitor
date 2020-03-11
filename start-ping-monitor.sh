#!/bin/bash

MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
sudo nohup $MY_PATH/ping-monitor.sh $1 >/dev/null &
