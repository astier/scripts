#!/usr/bin/env sh

case $1 in
    -) amixer set Master 5%- > /dev/null ;;
    +) amixer set Master 5%+ > /dev/null ;;
    =) amixer set Master toggle > /dev/null ;;
    *) amixer get Master | tail -n1 | awk -F'[][]' '{ print $2 }' ;;
esac

