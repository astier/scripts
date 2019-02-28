#!/usr/bin/env bash

# Sets the wallpaper and stores the image-path in ~/.wallpaper

[[ "$1" == "" ]] && echo "Specify an image." && exit
[[ ! -f "$1" ]] && echo "File does not exist." && exit
feh --bg-fill "$1"
FILE_PATH=$(readlink -f "$1")
echo "$FILE_PATH" > ~/.wallpaper
