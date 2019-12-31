#!/usr/bin/env sh

INPUT=$(printf "suspend\npoweroff\nreboot\nlock\nsuspend-lock")

case $1 in
    -t) action=$(echo "$INPUT" | fzf) ;;
    *) action=$(echo "$INPUT" | dmenu) ;;
esac

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
