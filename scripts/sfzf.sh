#!/usr/bin/env sh

[ $# -eq 0 ] && return

[ -t 0 ] && matches=$(find -type f $FIND_ARGS) || matches=$(cat)
[ -z "$matches" ] && matches=$(find -type f $FIND_ARGS)

for pattern in "$@"; do
    patterns="$patterns\|$pattern"
    matches=$(echo "$matches" | grep "$pattern")
done
patterns=$(echo "$patterns" | sed 's/^\\|//')

IFS='
'
for match in $matches; do
    patterns_occurrences=$(echo "$match" | grep -o "$patterns" | tr -d "\n")
    rank=$(((${#patterns_occurrences} * 100) / ${#match}))
    matches_ranked="$matches_ranked$rank $match\n"
done
matches_ranked=$(echo "$matches_ranked" | sort -g | cut -d" " -f2)
unset IFS

if [ -n "$matches_ranked" ]; then
    echo "$matches_ranked" | grep --color=always "$patterns" >&2
    echo "$matches_ranked" | tail -n1
fi
