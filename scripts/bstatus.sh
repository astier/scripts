#!/usr/bin/env sh

BAT_DIR=/sys/class/power_supply/BAT0
[ ! -d "$BAT_DIR" ] && echo NO BATTERY FOUND. EXIT. && return

while true; do
	bat_cap=$(cat $BAT_DIR/capacity)
	if [ "$(cat /sys/class/power_supply/BAT0/status)" = "Charging" ]; then
		[ "$bat_cap" -eq 80 ] && echo BAT 80% | dmenu -sf "#ff5050"
	elif [ "$bat_cap" -eq 40 ]; then
		echo BAT 40% | dmenu -sf "#ff5050"
	elif [ "$bat_cap" -lt 10 ]; then
		echo BAT "$bat_cap"% | dmenu -sf "#ff5050"
	fi
	sleep 120
done &
