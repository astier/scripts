#!/usr/bin/env sh

exec find . -mindepth 1 \
    -name '.*' -prune -o \
    -name __pycache__ -prune -o \
    "$@" -print \
| cut -c3-
