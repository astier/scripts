#!/usr/bin/env sh

if [ -x "$(command -v fd)" ]; then
    exec fd --type file --hidden --exclude .git
elif [ -x "$(command -v rg)" ]; then
    exec rg --files
elif [ -x "$(command -v git)" ] && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    exec git ls-files --deduplicate
else
    exec ffind -type f 2> /dev/null
fi
