#!/usr/bin/env sh

BUFFER=~/.cache/wal
SLEEP_TIME=1200

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
    if [ "$(pgrep -af wal | grep "bin/wal -l" | grep -cv grep)" -gt 2 ]; then
        echo AN INSTANCE IS ALREADY RUNNING && return
    fi
    while true; do
        set_random_wp "$(dirname "$(cat "$BUFFER")")"
        sleep "$SLEEP_TIME"
    done
}

[ ! -r $BUFFER ] && touch $BUFFER

case $1 in
    "") set_random_wp . && return ;;
    -l) loop "$2" && return ;;
    -d) delete_wp && return ;;
    -*) echo INVALID ARGUMENTS && return ;;
esac

if [ -d "$1" ]; then
    set_random_wp "$1"
elif file -b --mime-type "$1" | grep -q image; then
    set_wp "$1"
else
    echo INVALID ARGUMENTS >&2
    exit 1
fi
