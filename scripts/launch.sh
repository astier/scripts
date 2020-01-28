#!/usr/bin/env sh

cmds=$(printf "%s" "$PATH" | xargs -d: -I{} find -L {} -maxdepth 1 -mindepth 1 -executable -type f -printf "%P\n" | sort -u)
$TERMINAL --class launcher -d 32 8 -e sh -c "nohup \$(echo \"$cmds\" | fzf) >/dev/null 2>&1"
