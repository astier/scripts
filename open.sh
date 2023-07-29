#!/usr/bin/env bash

edit() {
    if [ -e "$1" ] && [ ! -w "$1" ]; then
        exec sudo -E "$EDITOR" "$@"
    elif [ ! -e "$1" ] && [ -z "$(find . -maxdepth 0 -user "$USER")" ]; then
        exec sudo -E "$EDITOR" "$@"
    else
        exec "$EDITOR" "$@"
    fi
}

open() {
    [ $# = 0 ] && return
    [ "$1" = -n ] && TEST=$1 && shift
    CMD="edit"
    EXTENSION=$(echo "$1" | tr "[:upper:]" "[:lower:]")
    case $EXTENSION in
        *.jpg | *.jpeg | *.png)
            if path=$(command -v gthumb); then
                CMD=$path
            else CMD=$BROWSER; fi ;;
        *.odt | *.ods | *.docx | *.csv | *.xlsx)
            CMD=libreoffice ;;
        *.pdf)
            CMD=$BROWSER ;;
        *.webm | *.mp4 | *.mkv)
            if path=$(command -v mpv); then
                CMD=$path
            else CMD=$BROWSER; fi ;;
    esac
    if [ "$CMD" = edit ]; then
        [ "$TEST" = -n ] && exit 1
        "$CMD" "$@"
    else
        [ "$TEST" = -n ] && exit 0
        spawn "$CMD" "$@"
    fi
}

files=( "${@}" )
if [ $# = 0 ]; then
    mapfile -t files < <(fzf)
    open "${files[@]}"
else
    open "$@"
fi
