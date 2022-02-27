#!/usr/bin/env sh

DIR=/sys/class/power_supply/BAT0

[ ! -d "$DIR" ] && echo NO BATTERY FOUND && return

notify() { tmux -L tty clock-mode; sudo chvt 2; }

loop() {
    if [ "$(pgrep -f "bstatus -l" | wc -l)" -gt 2 ]; then
        echo AN INSTANCE IS ALREADY RUNNING && return
    fi
    while true; do
        capacity=$(cat $DIR/capacity)
        if [ "$(cat $DIR/status)" = "Charging" ]; then
            [ "$capacity" -eq 90 ] && notify "$capacity"
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
    -*) echo INVALID ARGUMENTS ;;
esac
