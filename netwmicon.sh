#!/bin/sh

echo 'unsigned long icon[] = {'
identify -format '%w, %h,\n' "$1" | sed 's/^/	/'
# imagemagick and inkscape need to be installed
convert -background none "$1" RGBA: | hexdump -ve '"0x%08x, "' | fmt | sed 's/^/	/'
echo "};"
