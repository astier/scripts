#!/usr/bin/env sh

BATTERY=/sys/class/power_supply/BAT0

[ ! -d "$BATTERY" ] && echo NO BATTERY FOUND && exit 1

loop() {
    if [ "$(pgrep -f "bstatus -l" | wc -l)" -gt 2 ]; then
        echo An instance is already running. && exit 1
    fi
    while sleep 2m; do
        if [ "$(cat $BATTERY/status)" = "Discharging" ]; then
            if [ "$(cat $BATTERY/capacity)" -le 5 ]; then
                systemctl suspend
            fi
        fi
    done
}

case $1 in
    "") echo "$(cat $BATTERY/capacity)%" ;;
    -l) loop ;;
    -*) echo INVALID ARGUMENTS ;;
esac
