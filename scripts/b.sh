#!/usr/bin/env bash

WP_CONF="$HOME/.local/share/wallpaper"

set_wp() {
	feh --bg-fill "$1"
	realpath "$1" > "$WP_CONF"
}

get_random_wp() {
	WP=$(find "$1" -type f | grep -i -e .jpg -e .jpeg -e .png | shuf -n1)
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
		WP_NEW=$(get_random_wp "$WP_DIR") &&
		set_wp "$WP_NEW"
		rm "$WP_OLD"
	else
		echo "Config-File is corrupt: $WP_OLD" >&2
		exit 1
	fi
}

loop() {
	WP=$(get_random_wp "$1") &&
	set_wp "$WP"
	sleep "$2"
	while true; do
		WP_DIR=$(dirname "$(cat "$WP_CONF")")
		WP=$(get_random_wp "$WP_DIR") &&
		set_wp "$WP"
		sleep "$2"
	done
}

# Process arguments
if [ "$#" == 0 ]; then
	WP=$(get_random_wp .) &&
	set_wp "$WP"
elif [[ "$1" = -* ]]; then
	if [ "$1" == "-l" ] && [ -d "$2" ] && [[ "$3" =~ ^[0-9]+$ ]]; then
		if find "$2" -type f | grep -iq -e .jpg -e .jpeg -e .png; then
			loop "$2" "$3"
		else
			echo "No images found in provided directory." >&2
			exit 1
		fi
	elif [ "$1" == "-d" ]; then
		delete_wp
	else
		echo "Arguments are not valid." >&2
		exit 1
	fi
elif [ -d "$1" ]; then
	WP=$(get_random_wp "$1") &&
	set_wp "$WP"
elif file -b --mime-type "$1" | grep -q image; then
	set_wp "$1"
else
	echo "Arguments are not valid." >&2
	exit 1
fi
