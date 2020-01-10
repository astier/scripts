#!/usr/bin/env sh

if [ $# = 0 ]; then
    if [ -f main.py ]; then
        python main.py
    elif [ -f setup.sh ]; then
        sh setup.sh
    elif [ -f main.tex ]; then
        latexmk -pdf
    elif [ -f Makefile ]; then
        [ -f config.h ] && rm -f config.h
        sudo make install clean
    else
        echo No appropriate action can be applied.
    fi
else
    case $1 in
        *.py) python "$@" ;;
        *.sh) sh "$@" ;;
        *.tar.gz) tar -xzf "$@" ;;
        *.tex) latexmk -pdf "$@" ;;
        *.zip) unzip "$@" ;;
        *) echo Extension not recognized. ;;
    esac
fi
