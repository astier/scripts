#!/usr/bin/env sh

INPUT=$(printf "suspend\npoweroff\nreboot\nlock\nsuspend-lock")
action=$(echo "$INPUT" | fzf)
case $action in
    lock) slock ;;
    poweroff) poweroff ;;
    reboot) reboot ;;
    suspend) systemctl suspend ;;
    suspend-lock)
        (slock &)
        systemctl suspend
        ;;
esac
