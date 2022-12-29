#!/usr/bin/env sh

BATTERY=/sys/class/power_supply/BAT0

[ ! -d "$BATTERY" ] && echo NO BATTERY FOUND && exit 1

blink() {
    old_brightness=$(brightness ?)
    brightness 1% && sleep 1
    brightness "$old_brightness" && sleep 1
}

loop() {
    if [ "$(pgrep -f "bstatus -l" | wc -l)" -gt 2 ]; then
        echo An instance is already running. && exit 1
    fi
    while true; do
        capacity=$(cat $BATTERY/capacity)
        status=$(cat $BATTERY/status)
        if [ "$status" = "Discharging" ]; then
            if [ "$capacity" -le 10 ]; then
                blink && blink
            elif [ "$capacity" -le 5 ]; then
                systemctl suspend
            fi
        fi
        sleep 1m
    done
}

case $1 in
    "") echo "$(cat $BATTERY/capacity)%" ;;
    -l) loop ;;
    -*) echo INVALID ARGUMENTS ;;
esac
