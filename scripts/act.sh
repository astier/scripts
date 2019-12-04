#!/usr/bin/env sh

if [ $# -eq 0 ]; then
    if [ -f main.py ]; then
        python main.py
    elif [ -f setup.sh ]; then
        sh setup.sh
    elif [ -f config.def.h ]; then
        sudo make install clean
        rm config.h
    else
        echo No appropriate action can be applied.
    fi
else
    for last; do true; done
    case $last in
        *.py) python "$@" ;;
        *.sh) sh "$@" ;;
        *) echo Extension not recognized. ;;
    esac
fi
