#!/usr/bin/env sh

battery=$(cat /sys/class/power_supply/BAT0/capacity)
brightness=$(light | cut -d. -f1)
date_time=$(date "+%R")
mute=$(pulsemixer --get-mute)
volume=$(pulsemixer --get-volume | cut -d" " -f1)
echo "$date_time | BAT $battery | LIGHT $brightness | VOL $volume | MUTED $mute"
