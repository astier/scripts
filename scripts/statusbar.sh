#!/bin/bash

##############################################################
# Updates dwms' satusbar by writing to the WN_NAME variable. #
##############################################################

dat () {
	echo " $(date +%H:%M)"
}

bat () {
	BAT=$(cat /sys/class/power_supply/BAT0/capacity)
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
