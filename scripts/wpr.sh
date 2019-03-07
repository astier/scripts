#!/usr/bin/env bash

# Sets a random wallpaper from a given directory in a given interval
# Stores the path to the current wallpaper in ~/.wallpaper
while true; do
	WALLPAPER=$(ls "$1" | shuf -n1)
	wps "$1/$WALLPAPER"
	sleep 600
done
