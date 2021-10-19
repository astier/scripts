#!/usr/bin/env sh

edit() {
    if [ -e "$1" ] && [ ! -w "$1" ]; then
        exec sudo "$EDITOR" "$@"
    elif [ ! -e "$1" ] && [ -z "$(find . -maxdepth 0 -user "$USER")" ]; then
        exec sudo "$EDITOR" "$@"
    else
        exec "$EDITOR" "$@"
    fi
}

open() {
    [ $# = 0 ] && return
    [ "$1" = -n ] && TEST=$1 && shift
    CMD="edit"
    case $1 in
        *.jpg | *.JPG | *.png) CMD=gthumb ;;
        *.ods) CMD=libreoffice ;;
        *.pdf) CMD=$BROWSER ;;
    esac
    if [ "$CMD" = edit ]; then
        [ "$TEST" = -n ] && exit 1
        "$CMD" "$@"
    else
        [ "$TEST" = -n ] && exit 0
        nohup "$CMD" "$@" > /dev/null 2>&1 &
    fi
}

if [ $# = 0 ]; then
    open $(fzf)
else
    open "$@"
fi
