#!/usr/bin/env sh

# Exit if Xorg is not running
! pidof Xorg > /dev/null && exit
# Exit if autorandr is installed
find /usr/bin/ -type f -name autorandr -print -quit | grep -q . && echo exit: autorandr is installed && exit

intern=eDP-1
extern=HDMI-1

if xrandr | grep -q "$extern connected"; then
    xrandr --output "$intern" --off --output "$extern" --auto
else
    xrandr --output "$extern" --off --output "$intern" --auto
fi
