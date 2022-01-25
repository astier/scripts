#!/usr/bin/env sh

if [ $# = 0 ] || [ -z "$1" ]; then
    ls -Av --color --group-directories-first
elif [ -d "$1" ]; then
    ls -Av --color --group-directories-first "$1"
elif [ ! -f "$1" ]; then
    echo File "$1" does not exist.
else
    case "$1" in
        *) head -n "${2:-29}" "$1" ;;
    esac
fi
