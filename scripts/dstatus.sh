#!/usr/bin/env sh

bat() {
	bat_dir=/sys/class/power_supply/BAT0
	[ ! -d "$bat_dir" ] && return
	bat_cap=$(cat $bat_dir/capacity)
	if [ "$(cat /sys/class/power_supply/BAT0/status)" = "Charging" ]; then
		icon=""
	elif [ "$bat_cap" -eq 10 ]; then
		icon=""
		notify-send -u critical "BATTERY LOW!"
	elif [ "$bat_cap" -lt 15 ]; then
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

while true; do
	xsetroot -name "$(bat)  $(dat)"
	sleep 60
done
