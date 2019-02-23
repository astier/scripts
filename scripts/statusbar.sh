#!/bin/bash

###
# Writes to WM_NAME of X11 to generate dwms' statusbar.
###

BAT=$(cat /sys/class/power_supply/BAT0/capacity)
SYMBOL=""
if [ $(echo "$BAT < 15" | bc) == 1 ]; then
	SYMBOL=""
elif [ $(echo "$BAT < 35" | bc) == 1 ]; then
	SYMBOL=""
elif [ $(echo "$BAT < 65" | bc) == 1 ]; then
	SYMBOL=""
elif [ $(echo "$BAT < 85" | bc) == 1 ]; then
	SYMBOL=""
else
	SYMBOL=""
fi
echo "$SYMBOL  $BAT"
