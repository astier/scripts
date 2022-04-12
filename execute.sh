#!/usr/bin/env sh

tex() {
    if pidof -q zathura ; then
        exec latexmk -pdf
    else
        exec latexmk -pdf -pv
    fi
}

if [ $# = 0 ]; then
    if [ -f main.py ]; then
        exec python main.py
    elif [ -f setup.sh ]; then
        exec sh setup.sh
    elif [ -f main.tex ]; then
        exec tex
    elif [ -f Makefile ]; then
        exec make install
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
