#!/usr/bin/env bash

battery=$(cat /sys/class/power_supply/BAT0/capacity)
date_time=$(date "+%a %d.%m.%Y %R")
brightness=$(light | cut -d. -f1)
volume=$(pulsemixer --get-volume | cut -d" " -f1)
mute=$(pulsemixer --get-mute)
echo "MUTED $mute | VOL $volume | LIGHT $brightness | BAT $battery | $date_time"
