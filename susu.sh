#!/usr/bin/env sh

[ -n "$1" ] && exec su -c "$(printf ' "%s"' "$@")"
