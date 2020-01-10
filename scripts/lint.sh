#!/usr/bin/env sh

[ ! -f "$1" ] && echo File "$1" does not exist. && exit

case $1 in
    *.py) pylint "$1" ;;
    *.sh) shellcheck "$1" ;;
    *.tex) chktex -q "$1" ;;
    *) echo Extension not recognized. ;;
esac
