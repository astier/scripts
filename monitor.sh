#!/usr/bin/env sh

# Exit if Xorg is not running
! pidof Xorg > /dev/null && exit

configure() { xrandr --output "$1" --auto --primary --output "$2" --off; }

MONITORS=$(xrandr)

if echo "$MONITORS" | grep -q "LVDS-1 connected"; then
    intern=LVDS-1
    if echo "$MONITORS" | grep -q "DP-2 connected"; then
        extern=DP-2
        echo $extern
    else
        extern=VGA-1
    fi
elif echo "$MONITORS" | grep -q "eDP-1 connected"; then
    intern=eDP-1
    extern=HDMI-1
else
    echo Internal monitor could not be detected.
    exit
fi

if echo "$MONITORS" | grep -q "$extern connected"; then
    configure "$extern" "$intern"
else
    configure "$intern" "$extern"
fi
