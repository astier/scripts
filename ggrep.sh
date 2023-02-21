#!/usr/bin/env sh

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    exec git grep -In --break --heading "$@"
else
    exec git grep -In --break --heading --no-index --exclude-standard "$@"
fi
