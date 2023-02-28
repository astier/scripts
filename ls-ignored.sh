#!/usr/bin/env sh

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    patterns=$(find -L . -name .git -prune -o -print | git check-ignore -v --stdin | cut -f1 | cut -d: -f3 | uniq)
    patterns="$patterns\n"$(echo "$patterns" | grep '/$' | sed 's/^/*\//' | sed 's/\/$/\/*/')
    echo "$patterns"
fi
