#!/usr/bin/env sh

BUFFER=/tmp/x_buffer
[ ! -f $BUFFER ] && touch $BUFFER

add_files() {
	for p; do
		p=$(realpath -- "$p")
		if grep -qx "$p" $BUFFER; then
			echo Already in buffer: "$p"
		elif [ -f "$p" ] || [ -d "$p" ]; then
			echo "$p" >> $BUFFER
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
	done < $BUFFER
	: > $BUFFER
}

move_files() {
	while read -r LINE; do
		if [ -f "$LINE" ] || [ -d "$LINE" ]; then
			mv -i "$LINE" . &&
				echo Moved: "$LINE"
		else
			echo Doesn\'t exist: "$LINE"
		fi
	done < $BUFFER
	: > $BUFFER
}

case $@ in
	"") cat $BUFFER ;;
	-c) : > $BUFFER ;;
	-p) paste_files ;;
	-m) move_files ;;
	-*)
		echo Invalid arguments. >&2
		exit 1
		;;
	*) add_files "$@" ;;
esac
