#!/usr/bin/env sh

DIR=/sys/class/power_supply/BAT0

[ ! -d "$DIR" ] && echo NO BATTERY FOUND && return

notify() { (echo "$1"% | dmenu -p "BATTERY " > /dev/null 2>&1 &); }

while true; do
    bat_cap=$(cat $DIR/capacity)
    if [ "$(cat $DIR/status)" = "Charging" ]; then
        [ "$bat_cap" -eq 80 ] && notify "$bat_cap"
    elif [ "$bat_cap" -eq 10 ]; then
        notify "$bat_cap"
    elif [ "$bat_cap" -lt 5 ]; then
        systemctl suspend
    fi
    sleep 120
done
