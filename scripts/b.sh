#!/usr/bin/env bash

BUFFER="$HOME/.local/share/wallpaper"
SLEEP_TIME=1500

set_wp() {
	feh --bg-fill "$1"
	realpath "$1" > "$BUFFER"
}

get_random_wp() {
	WP=$(find "$1" -type f | grep -i -e .jpg -e .jpeg -e .png | shuf -n1)
	if [ -z "$WP" ]; then
		echo No images found in provided directory. >&2
		exit 1
	fi
	realpath "$WP"
}

set_random_wp() {
	if WP_NEW=$(get_random_wp "$1"); then
		set_wp "$WP_NEW"
	else
		exit 1
	fi
}

delete_wp() {
	WP_OLD=$(cat "$BUFFER")
	if file -b --mime-type "$WP_OLD" | grep -q image; then
		set_random_wp "$(dirname "$WP_OLD")"
		rm "$WP_OLD"
	else
		echo Wallpaper-Path is corrupt: "$WP_OLD" >&2
		exit 1
	fi
}

loop() {
	while true; do
		set_random_wp "$(dirname "$(cat "$BUFFER")")"
		sleep "$SLEEP_TIME"
	done
}

if [ "$#" == 0 ]; then
	set_random_wp .
elif [[ "$1" = -* ]]; then
	if [ "$1" == "-l" ]; then
		loop
	elif [ "$1" == "-d" ]; then
		delete_wp
	else
		echo Invalid arguments. >&2
		exit 1
	fi
elif [ -d "$1" ]; then
	set_random_wp "$1"
elif file -b --mime-type "$1" | grep -q image; then
	set_wp "$1"
else
	echo Invalid arguments. >&2
	exit 1
fi
