#!/usr/bin/env sh

case $1 in
    "")
        if [ -r main.py ]; then
            $EDITOR main.py
        elif [ -r setup.sh ]; then
            $EDITOR setup.sh
        elif [ -r config.def.h ]; then
            $EDITOR config.def.h
        else
            echo No file found.
        fi
        ;;
    -t)
        if [ -r report/main.tex ]; then
            $EDITOR report/main.tex
        elif [ -r main.tex ]; then
            $EDITOR main.tex
        else
            echo main.tex not found.
        fi
        ;;
    -r)
        if [ -r README.md ]; then
            $EDITOR README.md
        elif [ -r README ]; then
            $EDITOR README
        else
            echo README not found.
        fi
        ;;
esac
