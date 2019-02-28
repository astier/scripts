#!/usr/bin/env bash

# Move current wallpaper to trash and set new random wallpaper

WALLPAPER_OLD=$(cat ~/.wallpaper) || exit
WALLPAPER_DIR=$(dirname "$WALLPAPER_OLD")
WALLPAPER_NEW=$(ls "$WALLPAPER_DIR" | shuf -n1)
wps "$WALLPAPER_DIR/$WALLPAPER_NEW"
rm "$WALLPAPER_OLD"
