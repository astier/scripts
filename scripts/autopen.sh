#!/usr/bin/env sh

if [ -r main.py ]; then
    $EDITOR main.py
elif [ -r main.tex ]; then
    $EDITOR main.tex
elif [ -r setup.sh ]; then
    $EDITOR setup.sh
elif [ -r config.def.h ]; then
    $EDITOR config.def.h
else
    echo No appropriate file found.
fi
