#!/usr/bin/env sh

execute() {
    shift
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
}

open() {
    shift
    if [ $# -eq 0 ]; then
        if [ -r main.py ]; then
            $EDITOR main.py
        elif [ -r setup.sh ]; then
            $EDITOR setup.sh
        elif [ -r config.def.h ]; then
            $EDITOR config.def.h
        else
            echo No file found.
        fi
    elif [ "$1" = -t ]; then
        if [ -r report/main.tex ]; then
            $EDITOR report/main.tex
        elif [ -r main.tex ]; then
            $EDITOR main.tex
        else
            echo No main.tex found.
        fi
    fi
}

case $1 in
    -e) execute "$@" ;;
    -o) open "$@" ;;
    *) echo Invalid arguments. ;;
esac
