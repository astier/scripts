#!/usr/bin/env sh

if [ -x "$(command -v fd)" ]; then
    exec fd --type directory --hidden --exclude .git
elif [ -x "$(command -v rg)" ]; then
    exec rg --files -0 | xargs -0 dirname | sed /^\.$/d | sort -u
elif [ -x "$(command -v git)" ] && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    exec git ls-files -z | xargs -0 dirname | sed /^\.$/d | sort -u
else
    exec ffind -type d 2> /dev/null
fi
