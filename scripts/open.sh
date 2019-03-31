#!/usr/bin/env bash

if [ "$1" == "" ]; then
	feh
elif [ ! -f "$1" ] && [ ! -d "$1" ]; then
	nvim "$@"
else
	xdg-open "$@"
fi
