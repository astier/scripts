#!/usr/bin/env sh

battery=$(cat /sys/class/power_supply/BAT0/capacity)
date_time=$(date "+%R")
mute=$(pulsemixer --get-mute)
volume=$(pulsemixer --get-volume | cut -d" " -f1)
echo "MUTED $mute | VOL $volume | BAT $battery | $date_time"
