#!/usr/bin/env bash

# Sets the wallpaper and stores the image-path in ~/.local/share/wallpaper

if [ "$1" == "" ]; then
	echo "Specify an image."
elif [ ! -f "$1" ];then
	echo "File does not exist."
else
	hsetroot -fill "$1"
	FILE_PATH=$(readlink -f "$1")
	echo "$FILE_PATH" > ~/.local/share/wallpaper
fi
