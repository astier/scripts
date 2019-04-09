#!/usr/bin/env bash

if [ "$#" == 0 ]; then
	feh
elif [ "$#" == 1 ] && [ -f "$1" -o -d "$1" ]; then
	xdg-open "$@"
else
	nvim "$@"
fi
