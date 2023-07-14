#!/usr/bin/env sh

STEP_SIZE=5%

case $1 in
    -) brightnessctl set "$STEP_SIZE-" ;;
    +) brightnessctl set "$STEP_SIZE+" ;;
    *) brightnessctl set "$1" ;;
esac

