#!/usr/bin/env sh

BATTERY=/sys/class/power_supply/BAT0

[ ! -d "$BATTERY" ] && echo NO BATTERY FOUND && exit 1

notify() { dunstify -h string:x-dunst-stack-tag:battery -u critical "Battery: $1" ; }

loop() {
    if [ "$(pgrep -f "bstatus -l" | wc -l)" -gt 2 ]; then
        echo An instance is already running. && exit 1
    fi
    while true; do
        capacity=$(cat $BATTERY/capacity)
        if [ "$(cat $BATTERY/status)" = "Discharging" ]; then
            if [ "$capacity" -le 10 ]; then
                notify "$capacity"
            elif [ "$capacity" -le 5 ]; then
                systemctl suspend
            fi
        fi
        sleep 120
    done
}

case $1 in
    "") echo "$(cat $BATTERY/capacity)%" ;;
    -l) loop ;;
    -*) echo INVALID ARGUMENTS ;;
esac
