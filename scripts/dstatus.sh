#!/usr/bin/env sh

bat() {
	bat_dir=/sys/class/power_supply/BAT0
	[ ! -d "$bat_dir" ] && return
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

dat() { echo " $(date +%H:%M)"; }

drb() { pgrep dropbox > /dev/null && echo ; }

while true; do
	xsetroot -name "$(drb)  $(bat)  $(dat)"
	sleep 60
done
