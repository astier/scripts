#!/usr/bin/env sh

INPUT=$(printf "suspend\nreboot\npoweroff\nlock")

case $1 in
    -t) action=$(echo "$INPUT" | fzf) ;;
    *) action=$(echo "$INPUT" | dmenu) ;;
esac

case $action in
    suspend)
        (slock &)
        systemctl suspend
        ;;
    reboot) reboot ;;
    poweroff) poweroff ;;
    lock) slock ;;
esac
