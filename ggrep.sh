#!/usr/bin/env sh

exec grep -IRn --color=auto --exclude-dir=.?* "$@"
