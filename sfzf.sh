#!/usr/bin/env sh

# TODO: sort first patterns by length
# TODO: test grep/sorting with perl, python, awk, sed, ripgrep, grep

# Filter matches based on patterns
matches=$(cat)
for pattern in "$@"; do
    patterns="$patterns\|$pattern"
    matches=$(echo "$matches" | grep -i "$pattern")
done
[ -z "$matches" ] && exit

# Get shortest match
# echo "$matches" | awk 'NR==1 || length<rank {rank=length; line=$0} END {print line}'

# Sort matches based on length and highlight patterns (~305ms)
# echo "$matches" | awk '{print length, $0}' | sort -nrs | cut -d" " -f2 | grep --color=always "$patterns"
echo "$matches" | perl -e 'print sort { length($b) <=> length($a) } <>' | grep --color=always "$patterns"
