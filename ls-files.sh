#!/usr/bin/env sh

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    exec git ls-files
else
    exec ffind -type f 2> /dev/null
fi
