#!/bin/bash

###
# Writes to WM_NAME of X11 to generate dwms' statusbar.
###

bat () {
	BAT=$(cat /sys/class/power_supply/BAT0/capacity)
	SYMBOL=""
	if [ "$BAT" -lt 15 ]; then
		SYMBOL=""
	elif [ "$BAT" -lt 35 ]; then
		SYMBOL=""
	elif [ "$BAT" -lt 65 ]; then
		SYMBOL=""
	elif [ "$BAT" -lt 85 ]; then
		SYMBOL=""
	else
		SYMBOL=""
	fi
	echo "$SYMBOL $BAT%"
}

dat () {
	DATE=$(date +%H:%M)
	echo " $DATE"
}

xsetroot -name " $(bat)  $(dat)"
