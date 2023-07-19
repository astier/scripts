#!/usr/bin/env sh

if [ -x "$(command -v rg)" ]; then
    exec rg "$@"
elif git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    if [ "$1" = "--vimgrep" ]; then
        shift
        exec git grep -In --column "$@"
    else
        exec git grep -In --break --heading "$@"
    fi
else
    if [ "$1" = "--vimgrep" ]; then
        shift
        exec git grep -In --column --no-index --exclude-standard "$@"
    else
        exec git grep -In --break --heading --no-index --exclude-standard "$@"
    fi
fi
