#!/usr/bin/env sh

if [ -r main.py ]; then
    $EDITOR main.py
elif [ -r main.tex ]; then
    $EDITOR main.tex
elif [ -r setup.sh ]; then
    $EDITOR setup.sh
elif [ -r config.def.h ]; then
    $EDITOR config.def.h
elif [ -r config.h ]; then
    $EDITOR config.h
elif [ -r Makefile ]; then
    $EDITOR Makefile
else
    echo No appropriate file found.
fi
