#!/usr/bin/env sh

matches=$(cat)
for pattern in "$@"; do matches=$(echo "$matches" | grep "$pattern"); done
echo "$matches" | awk 'NR==1 || length<rank {rank=length; line=$0} END {print line}'
