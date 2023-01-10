#!/usr/bin/env sh

BATTERY=/sys/class/power_supply/BAT0

[ ! -d "$BATTERY" ] && echo NO BATTERY FOUND && exit 1

capacity() { cat $BATTERY/capacity; }

status() { cat $BATTERY/status; }

loop() {
    if [ "$(pgrep -f "bstatus" | wc -l)" -gt 2 ]; then
        echo An instance is already running. && exit 1
    fi
    while sleep 2m; do
        if [ "$(capacity)" -le 5 ] \
        && [ "$(status)" = "Discharging" ]; then
            systemctl suspend
        fi
    done
}

case $1 in
    -c) capacity ;;
    -s) status ;;
    "") loop ;;
     *) echo INVALID ARGUMENTS ;;
esac
