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
		SYMBOL=""
	elif [ "$BAT" -lt 40 ]; then
		SYMBOL=""
	elif [ "$BAT" -lt 60 ]; then
		SYMBOL=""
	elif [ "$BAT" -lt 85 ]; then
		SYMBOL=""
	else
		SYMBOL=""
	fi
	echo "$SYMBOL $BAT%"
}

xsetroot -name "$(bat)  $(dat)"
