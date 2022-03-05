#!/usr/bin/env sh

# Exit if Xorg is not running
! pidof Xorg > /dev/null && exit

# Get all connected monitors
MONITORS=$(xrandr | grep " connected " | cut -d" " -f1)

# Check if a monitor is connected
check() { echo "$MONITORS" | grep -q "$1" ; }

# Find external monitor
set -- HDMI-1 DP-2 VGA-1
for m in "$@"; do check "$m" && external="$m" && break; done

# Find internal monitor
set -- eDP-1 LVDS-1
for m in "$@"; do check "$m" && internal="$m" && break; done

# Configure monitors
if [ -n "$external" ] && [ -n "$internal" ]; then
    xrandr --output "$external" --auto --primary --output "$internal" --off
elif [ -z "$external" ] && [ -n "$internal" ]; then
    xrandr --output "$internal" --auto --primary
elif [ -n "$external" ] && [ -z "$internal" ]; then
    xrandr --output "$external" --auto --primary
else
    echo Neither an external nor an internal monitor could be found.
    exit 1
fi
