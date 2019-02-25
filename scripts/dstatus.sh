#!/usr/bin/env bash

# Updates dwms' satusbar by writing to the WN_NAME variable.

dat () {
	echo " $(date +%H:%M)"
}

bat () {
	BAT_DIR=/sys/class/power_supply/BAT0
	[[ ! -d "$BAT_DIR" ]] && return
	BAT=$(cat $BAT_DIR/capacity)
	if [ "$BAT" -lt 15 ]; then
		ICON=""
	elif [ "$BAT" -lt 40 ]; then
		ICON=""
	elif [ "$BAT" -lt 60 ]; then
		ICON=""
	elif [ "$BAT" -lt 85 ]; then
		ICON=""
	else
		ICON=""
	fi
	echo "$ICON $BAT%"
}

xsetroot -name "$(bat)  $(dat)"
