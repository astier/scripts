#!/usr/bin/env sh

# Exit if Xorg is not running
! pidof -q Xorg && exit

# Get all connected monitors
MONS=$(mons | head -n1 | cut -d' ' -f2)

if [ "$MONS" -lt 2 ]; then
    mons -o
else
    mons -s
fi
