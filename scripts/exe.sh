#!/usr/bin/env sh

if [ $# -eq 0 ]; then
    if [ -f main.py ]; then
        python main.py
    elif [ -f setup.sh ]; then
        sh setup.sh
    elif [ -f Makefile ]; then
        [ -f config.h ] && rm -f config.h
        sudo make install clean
    else
        echo No appropriate action can be applied.
    fi
else
    for last; do true; done
    case $last in
        *.py) python "$@" ;;
        *.sh) sh "$@" ;;
        *.tar.gz) tar -xzf "$@" ;;
        *.zip) unzip "$@" ;;
        *) echo Extension not recognized. ;;
    esac
fi
