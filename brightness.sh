#!/usr/bin/env sh

STEP_SIZE=5%

case $1 in
    -) brightnessctl -q set "$STEP_SIZE-" ;;
    +) brightnessctl -q set "$STEP_SIZE+" ;;
    *) brightnessctl -q set "$1" ;;
esac

