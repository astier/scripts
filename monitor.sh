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

# Determine output-monitor and brightness of internal monitor
if [ -n "$external" ]; then
    monitor="$external"
    brightness_xrandr=0
    brightness=0
elif [ -n "$internal" ]; then
    monitor="$internal"
    brightness_xrandr=1
    brightness=100
else
    echo Neither an external nor an internal monitor could be found.
    exit 1
fi

# Set output-monitor and brightness of internal monitor
xrandr --output "$monitor" --auto --primary

if [ -n "$internal" ]; then
    xrandr --output "$internal" --brightness "$brightness_xrandr"
    brightness "$brightness%"
fi
