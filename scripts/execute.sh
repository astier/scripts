#!/usr/bin/env sh

tex() {
    if [ "$(pidof zathura)" ]; then
        latexmk -pdf
        xdotool search --desktop 0 --class Zathura windowactivate
    else
        latexmk -pdf -pv
    fi
}

suckless() {
    [ -f config.h ] && rm -f config.h
    sudo make install clean
}

if [ $# = 0 ]; then
    if [ -f main.py ]; then
        python main.py
    elif [ -f setup.sh ]; then
        sh setup.sh
    elif [ -f main.tex ]; then
        tex
    elif [ -f Makefile ]; then
        suckless
    else
        echo No appropriate action can be applied.
    fi
else
    case $1 in
        *.py) python "$@" ;;
        *.sh) sh "$@" ;;
        *.tar.gz) tar -xzf "$@" ;;
        *.tex) tex ;;
        *.zip) unzip "$@" ;;
        config.def.h) suckless "$@" ;;
        *) echo Extension not recognized. ;;
    esac
fi
