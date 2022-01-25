#!/usr/bin/env sh

# Exit if Xorg is not running
! pidof Xorg > /dev/null && exit

configure() { xrandr --output "$1" --auto --primary --output "$2" --off; }

INFO=/tmp/xrandr_dump
xrandr > "$INFO"

if grep -q "LVDS-1 connected" "$INFO"; then
    intern=LVDS-1
    extern=VGA-1
elif grep -q "eDP-1 connected" "$INFO"; then
    intern=eDP-1
    extern=HDMI-1
else
    echo Internal monitor could not be detected.
    exit
fi

if xrandr | grep -q "$extern connected"; then
    configure "$extern" "$intern"
else
    configure "$intern" "$extern"
fi
