#!/usr/bin/env sh

exec grep -IRn --exclude-dir=.?* "$@"
