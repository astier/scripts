#!/usr/bin/env sh

[ ! -f "$1" ] && echo File "$1" does not exist. && exit

case $1 in
    *.py)
        isort "$1"
        black "$1"
        ;;
    *.sh) shfmt -w -ci -sr -p -s -i 4 "$1" ;;
    *) echo Extension not recognized. ;;
esac
