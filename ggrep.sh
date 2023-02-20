#!/usr/bin/env sh

exec grep -IRn --color=auto \
    --exclude-dir=.ccls-cache \
    --exclude-dir=.git \
    --exclude-dir=.idea \
    --exclude-dir=__pycache__ \
"$@"
