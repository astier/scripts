#!/usr/bin/env sh

eval "$(printf "%s" "$PATH" | xargs -d: -I{} find -L {} -maxdepth 1 -mindepth 1 -executable -type f -printf "%P\n" | sort -u | menu)"
