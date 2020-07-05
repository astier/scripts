#!/usr/bin/env sh

[ $# -eq 0 ] && return

[ -t 0 ] && matches=$(find -type f $FIND_ARGS) || matches=$(cat)
[ -z "$matches" ] && matches=$(find -type f $FIND_ARGS)

for pattern in "$@"; do
    patterns="$patterns\|$pattern"
    matches=$(echo "$matches" | grep "$pattern")
done
matches=$(echo "$matches" | awk '{print length, $0}' | sort -nrs | cut -d" " -f2)

if [ -n "$matches" ]; then
    echo "$matches" | grep --color=always "$patterns" >&2
    echo "$matches" | tail -n1
fi
