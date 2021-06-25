#!/bin/bash
# baraction.sh script for spectrwm status bar

## DISK
hdd() {
  hdd="$(df -h | awk 'NR==4{print $3, $5}')"
  echo -e "HDD: $hdd"
}

## RAM
mem() {
  mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 /1024.0 }'`
  echo -e "MEM: $mem"
}

## CPU
cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "CPU: $cpu%"
}

## NET
#net() {
#net="$(/home/storm/bin/netspeed)"
#echo -e "NET: $net"
#}


## TEMP
#temp() {
 # eval $(sensors | awk '/^Core 0/ {gsub(/°/,""); printf "CPU0=%s;", $3}')
 # eval $(sensors | awk '/^Core 1/ {gsub(/°/,""); printf "CPU1=%s;", $3}')
 # echo -e "TEMP: ${CPU0}/${CPU1}"
# }

## Updates
#updates() {
#updates="$(/home/storm/updates.sh)"
#echo -e "UPDATES: $updates"
#}
	
SLEEP_SEC=3
#loops forever outputting a line every SLEEP_SEC secs

# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the 
# echo output too long to display correctly.
while :; do
    echo "+@fg=4; $(hdd) +@fg=0; | +@fg=2; $(mem) +@fg=0; | +@fg=7; $(cpu) +@fg=0; |"
	sleep $SLEEP_SEC
done

