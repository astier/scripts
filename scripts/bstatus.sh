#!/usr/bin/env sh

DIR=/sys/class/power_supply/BAT0

[ ! -d "$DIR" ] && echo NO BATTERY FOUND && return

notify() { ($TERMINAL -n "notification" -g 64x128 sh -c "echo BATTERY $1; read _" &); }

loop() {
    if [ "$(pgrep -af bs | grep "bin/bs -l" | grep -cv grep)" -gt 2 ]; then
        echo AN INSTANCE IS ALREADY RUNNING && return
    fi
    while true; do
        capacity=$(cat $DIR/capacity)
        if [ "$(cat $DIR/status)" = "Charging" ]; then
            [ "$capacity" -eq 90 ] && notify "$capacity"
        elif [ "$capacity" -eq 15 ]; then
            notify "$capacity"
        elif [ "$capacity" -lt 10 ]; then
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
