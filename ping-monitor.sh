#!/bin/bash
# chmod +x ping-monitor.sh (prima di poter eseguire lo script)
# apt-get install moreutils (per poter eseguire il comando 'ts')

ScriptPath="`dirname \"$0\"`"              # relative
ScriptPath="`( cd \"$ScriptPath\" && pwd )`"  # absolutized and normalized

if [ "$1" ]; then
  TargetHost="$1"

  while true; do
    ping -c 100 $TargetHost |
    grep -A 3 "statistic" |
    tail -n +2 | head -n +1 |
    ts '%Y-%m-%d %H:%M:%S ,' |
    sed 's/ packets transmitted//' |
    sed '/errors/! s/ received/, /' |
    sed '/errors/ s/ received//' |
    sed 's/ errors//' |
    sed 's/ packet loss//' |
    sed 's/time //' |
    tee -a $ScriptPath/ping-stats-$TargetHost
  done
else
  # no target_host parameter
  echo "Syntax error: $0 {target_host}"
fi



