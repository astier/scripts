#!/usr/bin/env sh

if [ -x "$(command -v pulsemixer)" ]; then
    case $1 in
        -) pulsemixer --change-volume -4 ;;
        +) pulsemixer --change-volume +4 ;;
        =) pulsemixer --toggle-mute ;;
        ?) pulsemixer --get-volume | cut -d' ' -f1 ;;
        *) pulsemixer ;;
    esac
else
    case $1 in
        -) amixer set Master 2%- > /dev/null ;;
        +) amixer set Master 2%+ > /dev/null ;;
        =) amixer set Master toggle > /dev/null ;;
        \?) amixer get Master | tail -n1 | awk -F'[][]' '{ print $2 }' | sed s/%// ;;
        d) rm -f ~/.asoundrc ;;
        h) echo defaults.pcm.device 3 > ~/.asoundrc ;;
        "") alsamixer ;;
    esac
fi
