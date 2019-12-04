#!/usr/bin/env sh

INPUT=$(printf "suspend\nreboot\npoweroff\nlock\nlock-suspend")

case $1 in
    -t) action=$(echo "$INPUT" | fzf) ;;
    *) action=$(echo "$INPUT" | dmenu) ;;
esac

case $action in
    suspend) systemctl suspend ;;
    reboot) reboot ;;
    poweroff) poweroff ;;
    lock) slock ;;
    lock-suspend)
        (slock &)
        systemctl suspend
        ;;
esac
