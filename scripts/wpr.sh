#!/usr/bin/env bash

# Sets a random wallpaper from a given directory in a given interval
# Stores the path to the current wallpaper in ~/.wallpaper
WALLPAPERS=~/Pictures/luke_smith/Landscapes
while true; do
	WALLPAPER=$(ls "$WALLPAPERS" | shuf -n1)
	wps "$WALLPAPERS/$WALLPAPER"
	sleep 60
done