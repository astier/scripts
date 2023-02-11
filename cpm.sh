#!/usr/bin/env sh

BUFFER=/tmp/cpm

copy() {
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

paste() {
    while read -r LINE; do
        if [ -f "$LINE" ] || [ -d "$LINE" ]; then
            cp -fr "$LINE" . && echo Pasted: "$LINE"
        else
            echo Doesn\'t exist: "$LINE"
        fi
    done < $BUFFER
}

move() {
    while read -r LINE; do
        if [ -f "$LINE" ] || [ -d "$LINE" ]; then
            mv -f "$LINE" . && echo Moved: "$LINE"
        else
            echo Doesn\'t exist: "$LINE"
        fi
    done < $BUFFER
    : > $BUFFER
}

[ ! -f $BUFFER ] && touch $BUFFER

case $@ in
    "") cat $BUFFER ;;
    -c\ *)
        shift
        copy "$@"
        ;;
    -d) : > $BUFFER ;;
    -p) paste ;;
    -m) move ;;
    -*)
        echo Invalid arguments. >&2
        exit 1
        ;;
    *)
        : > $BUFFER
        copy "$@"
        ;;
esac
