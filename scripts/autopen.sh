#!/usr/bin/env sh

if [ -r main.py ]; then
    $EDITOR main.py
elif [ -r main.tex ]; then
    $EDITOR main.tex
elif [ -r setup.sh ]; then
    $EDITOR setup.sh
else
    echo No appropriate file found.
fi
