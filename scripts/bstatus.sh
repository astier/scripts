#!/usr/bin/env sh

BAT_DIR=/sys/class/power_supply/BAT0
[ ! -d "$BAT_DIR" ] && echo NO BATTERY FOUND. EXIT. && return

notify() { (echo BAT "$1"% | dmenu -p "BATTERY " > /dev/null 2>&1 &); }

while true; do
    bat_cap=$(cat $BAT_DIR/capacity)
    if [ "$(cat /sys/class/power_supply/BAT0/status)" = "Charging" ]; then
        [ "$bat_cap" -eq 80 ] && notify "$bat_cap"
    elif [ "$bat_cap" -eq 10 ]; then
        notify "$bat_cap"
    elif [ "$bat_cap" -lt 5 ]; then
        systemctl suspend
    fi
    sleep 120
done
