#!/usr/bin/env sh

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    exec git ls-files -z | xargs -0 dirname | sed /^\.$/d | sort -u
else
    exec ffind -type d 2> /dev/null
fi
