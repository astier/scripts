#!/usr/bin/env sh

cmd="$(printf "%s" "$PATH" | xargs -d: -I{} find -L {} -maxdepth 1 -mindepth 1 -executable -type f -printf "%P\n" | sort -u | menu)"
[ -n "$cmd" ] && setsid -f "$cmd" > /dev/null 2>&1
