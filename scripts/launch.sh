#!/usr/bin/env sh

$TERMINAL --class launcher -d 32 8 -e sh -c "nohup \$(printf \"%s\" \"\$PATH\" | xargs -d : -I {} find -L {} -maxdepth 1 -executable -type f -printf \"%P\\n\" | sort -u | fzf) >/dev/null 2>&1" >/dev/null 2>&1
