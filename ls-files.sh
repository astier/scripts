#!/usr/bin/env sh

if [ -x "$(command -v git)" ] && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    exec git ls-files
elif [ -x "$(command -v fd)" ]; then
    exec fd --type file --follow --hidden --exclude .git --color never
elif [ -x "$(command -v rg)" ]; then
    exec rg --files --color never --no-messages
else
    exec ffind -type f 2> /dev/null
fi
