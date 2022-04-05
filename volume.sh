#!/usr/bin/env sh

case $1 in
    -) pulsemixer --change-volume -5 ;;
    +) pulsemixer --change-volume +5 ;;
    =) pulsemixer --toggle-mute ;;
    ?) pulsemixer --get-volume ;;
    *) pulsemixer
esac

