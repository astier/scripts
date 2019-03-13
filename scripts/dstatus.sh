#!/usr/bin/env bash

# Updates dwms' satusbar by writing to the WN_NAME variable.

dat () {
	echo " $(date +%H:%M)"
}

bat () {
	bat_dir=/sys/class/power_supply/BAT0
	[[ ! -d "$bat_dir" ]] && exit
	bat_cap=$(cat $bat_dir/capacity)
	if [ "$bat_cap" -lt 15 ]; then
		icon=""
	elif [ "$bat_cap" -lt 40 ]; then
		icon=""
	elif [ "$bat_cap" -lt 60 ]; then
		icon=""
	elif [ "$bat_cap" -lt 85 ]; then
		icon=""
	else
		icon=""
	fi
	echo "$icon $bat_cap%"
}

while true; do
	xsetroot -name "$(bat)  $(dat)"
	sleep 60
done
