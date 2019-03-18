#!/usr/bin/env bash

if [ "$1" == "" ]; then
	feh
elif [ ! -f "$1" ] && [ ! -d "$1" ]; then
	nvim "$1"
else
	xdg-open "$1"
fi
