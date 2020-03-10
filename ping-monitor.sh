#!/bin/bash
# chmod +x ping-monitor.sh (prima di poter eseguire lo script)
# apt-get install moreutils (per poter eseguire il comando 'ts')
# l'orario e' in formato GMT (quindi 1 ora indietro)
# per ovviare al problema settare la variabile TZ (export TZ=CEST-1)

MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized

while true; do
        ping -c 100 8.8.8.8 |
        grep -A 3 "statistic" |
	tail -n +2 | head -n +1 |
	ts '%Y-%m-%d %H:%M:%S ,' |
	sed 's/ packets transmitted//' |
	sed '/errors/! s/ received/, /' |
	sed '/errors/ s/ received//' |
	sed 's/ errors//' |
	sed 's/ packet loss//' |
	sed 's/time //' |
	tee -a $MY_PATH/ping-stats
done


