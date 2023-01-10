#!/usr/bin/env sh

case $1 in
    -) wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- ;;
    +) wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ ;;
    =) wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle ;;
    ?) wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d. -f2 ;;
    *) wpctl status
esac

