#!/usr/bin/env sh

BATTERY=/sys/class/power_supply/BAT0

[ ! -d "$BATTERY" ] && echo No battery found. && exit 1

capacity() { cat $BATTERY/capacity; }

status() { cat $BATTERY/status; }

loop() {
    if [ "$(pgrep -f "bstatus" | wc -l)" -gt 2 ]; then
        echo An instance is already running. && exit 1
    fi
    while sleep 2m; do
        [ "$(status)" != "Discharging" ] && continue
        CAPACITY=$(capacity)
        if [ "$CAPACITY" -le 10 ]; then
            sudo systemctl suspend
        elif [ "$CAPACITY" -le 20 ] && pidof -q dunst; then
            dunstify -h string:x-dunst-stack-tag:battery -u critical "Battery: $CAPACITY"
        fi
    done
}

case $1 in
    -c) capacity ;;
    -s) status ;;
    "") loop ;;
     *) echo Invalid arguments. ;;
esac
