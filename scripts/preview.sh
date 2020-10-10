#!/usr/bin/env sh

if [ $# = 0 ] || [ -z "$1" ]; then
    ls -Av --color --group-directories-first && return
elif [ -d "$1" ]; then
    ls -Av --color --group-directories-first "$1" && return
elif [ ! -f "$1" ]; then
    echo File "$1" does not exist. && return
fi

case "$1" in
    *) head -n "${2:-29}" "$1" ;;
esac
