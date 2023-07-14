#!/usr/bin/env sh

STEP_SIZE=5%

case $1 in
    -) light -U "$STEP_SIZE" ;;
    +) light -A "$STEP_SIZE" ;;
    "?") light -G | cut -d. -f1 ;;
    *) light -S "$1" ;;
esac

