#!/usr/bin/env bash

BUFFER=/tmp/x_buffer
[[ ! -f "$BUFFER" ]] && touch "$BUFFER"

add_files() {
	for p do
		p=$(realpath "$p")
		if grep -qx "$p" "$BUFFER"; then
			echo Already in buffer: "$p"
		elif [ -f "$p" ] || [ -d "$p" ]; then
			echo "$p" >> "$BUFFER"
		else
			echo Does\'t exist: "$p"
		fi
	done
}

paste_files() {
	while read -r LINE; do
		if [ -f "$LINE" ] || [ -d "$LINE" ]; then
			cp -ir "$LINE" . &&
			echo Pasted: "$LINE"
		else
			echo Doesn\'t exist: "$LINE"
		fi
	done < "$BUFFER"
	:> "$BUFFER"
}

move_files() {
	while read -r LINE; do
		if [ -f "$LINE" ] || [ -d "$LINE" ]; then
			mv -i "$LINE" . &&
			echo Moved: "$LINE"
		else
			echo Doesn\'t exist: "$LINE"
		fi
	done < "$BUFFER"
	:> "$BUFFER"
}

if [ "$#" == 0 ]; then
	cat "$BUFFER"
elif [[ "$1" = -* ]]; then
	if [ "$1" == "-c" ]; then
		:> "$BUFFER"
	elif [ "$1" == "-p" ]; then
		paste_files
	elif [ "$1" == "-m" ]; then
		move_files
	else
		echo Invalid arguments. >&2
		exit 1
	fi
else
	add_files "$@"
fi
