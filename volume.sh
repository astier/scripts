#!/usr/bin/env sh

case $1 in
    -) pulsemixer --change-volume -4 ;;
    +) pulsemixer --change-volume +4 ;;
    =) pulsemixer --toggle-mute ;;
    ?) pulsemixer --get-volume | cut -d' ' -f1 ;;
    *) pulsemixer ;;
esac
