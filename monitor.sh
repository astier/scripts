#!/usr/bin/env sh

intern=eDP-1
extern=HDMI-1

if xrandr | grep -q "$extern connected"; then
    xrandr --output "$intern" --off --output "$extern" --auto
else
    xrandr --output "$extern" --off --output "$intern" --auto
fi