#!/usr/bin/env sh

exec find . -mindepth 1 \
    -name '.*' -prune -o \
    -name __pycache__ -prune -o \
    "$@" -print 2>&1 \
| grep -v "Permission denied" \
| cut -c3-
