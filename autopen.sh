#!/usr/bin/env sh

if [ -r main.py ]; then
    exec "$EDITOR" main.py
elif [ -r main.tex ]; then
    exec "$EDITOR" main.tex
elif [ -r setup.sh ]; then
    exec "$EDITOR" setup.sh
elif [ -r main.c ]; then
    exec "$EDITOR" main.c
elif [ -r config.def.h ]; then
    exec "$EDITOR" config.def.h
elif [ -r config.h ]; then
    exec "$EDITOR" config.h
elif [ -r Makefile ]; then
    exec "$EDITOR" Makefile
else
    echo No appropriate file found.
fi
