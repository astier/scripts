#!/usr/bin/env sh

if [ $# = 0 ]; then
    if [ -f main.py ]; then
        exec python main.py
    elif [ -f setup.sh ]; then
        exec sh setup.sh
    elif [ -f main.tex ]; then
        latexmk && pidof -q evince || spawn latexmk -pv
    elif [ -f Makefile ]; then
        exec sudo make install
    else
        echo No appropriate action can be applied.
    fi
else
    case $1 in
        *.js) exec node "$@" ;;
        *.py) exec python "$@" ;;
        *.sh) exec sh "$@" ;;
        *.tar.gz) exec tar -xzf "$@" ;;
        *.tex) tex ;;
        *.zip) exec unzip "$@" ;;
        *) echo Extension not recognized. ;;
    esac
fi
