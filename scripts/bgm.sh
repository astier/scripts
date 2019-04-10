#!/usr/bin/env bash

WP_CONF="$HOME/.local/share/wallpaper"

set_wp() {
	feh --bg-fill "$1"
	FILE_PATH=$(readlink -f "$1")
	echo "$FILE_PATH" > "$WP_CONF"
}

get_random_wp() {
	WP=$(find "$1" -type f | grep -i -e .jpg -e .jpeg -e .png | shuf -n1 | sed "s/^.\///")
	if [ -z "$WP" ]; then
		echo "No images found in provided directory." >&2
		exit 1
	fi
	realpath "$WP"
}

delete_wp() {
	WP_OLD=$(cat "$WP_CONF")
	if file -b --mime-type "$WP_OLD" | grep -q image; then
		WP_DIR=$(dirname "$WP_OLD")
		WP_NEW=$(get_random_wp "$WP_DIR")
		set_wp "$WP_NEW"
		rm "$WP_OLD"
	else
		echo "Config-file is corrupt: $WP_OLD" >&2
		exit 1
	fi
}

if [ "$1" == "-d" ]; then
	delete_wp
elif [ -d "$1" ]; then
	WP=$(get_random_wp "$1") &&
	set_wp "$WP"
elif file -b --mime-type "$1" | grep -q image; then
	set_wp "$1"
else
	echo "Argument is not valid." >&2
	exit 1
fi
