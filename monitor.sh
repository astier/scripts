#!/usr/bin/env sh

# Exit if Xorg is not running
! pidof Xorg > /dev/null && exit

MONITORS=$(xrandr | grep " connected " | cut -d" " -f1)

check() { echo "$MONITORS" | grep -q "$1" && monitor="$1"; }

if check HDMI-1; then
    brightness=0
elif check DP-2; then
    brightness=0
elif check VGA-1; then
    brightness=0
elif check eDP-1; then
    brightness=100
elif check LVDS-1; then
    brightness=100
else
    echo Monitor could not be detected.
    exit 1
fi

lux -S "$brightness%" > /dev/null
xrandr --output "$monitor" --auto --primary
