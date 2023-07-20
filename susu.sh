#!/usr/bin/env sh

[ "$1" = -E ] && shift
[ -n "$1" ] && exec su -c "$(printf ' "%s"' "$@")"
