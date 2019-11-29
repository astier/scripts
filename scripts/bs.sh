#!/usr/bin/env sh

DIR=/sys/class/power_supply/BAT0

[ ! -d "$DIR" ] && echo NO BATTERY FOUND && return

notify() { (echo "$1"% | dmenu -p "BATTERY " > /dev/null 2>&1 &); }

loop() {
    while true; do
        capacity=$(cat $DIR/capacity)
        if [ "$(cat $DIR/status)" = "Charging" ]; then
            [ "$capacity" -eq 80 ] && notify "$capacity"
        elif [ "$capacity" -eq 10 ]; then
            notify "$capacity"
        elif [ "$capacity" -lt 5 ]; then
            systemctl suspend
        fi
        sleep 120
    done
}

case $1 in
    "") cat $DIR/capacity ;;
    -l) loop ;;
    -*) echo Invalid arguments. ;;
esac
