#!/usr/bin/env sh

tex() {
    if [ $(pidof zathura) ]; then
        latexmk -pdf
        wmctrl -xa zathura
    else
        latexmk -pdf -pv
    fi
}

if [ $# = 0 ]; then
    if [ -f main.py ]; then
        python main.py
    elif [ -f setup.sh ]; then
        sh setup.sh
    elif [ -f main.tex ]; then
        tex
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
        *) echo Extension not recognized. ;;
    esac
fi
