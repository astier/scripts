#!/usr/bin/env sh

STEP_SIZE=10%

case $1 in
    -) lux -s "$STEP_SIZE" > /dev/null ;;
    +) lux -a "$STEP_SIZE" > /dev/null ;;
    ?) lux -G ;;
    *) lux -S "$1%" > /dev/null ;;
esac

