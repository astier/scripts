#!/usr/bin/env sh

exec find . -mindepth 1 \
    -name .ccls-cache -prune -o \
    -name .git -prune -o \
    -name .idea -prune -o \
    -name __pycache__ -prune -o \
    "$@" -printf "%P\n"
