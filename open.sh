#!/usr/bin/env bash

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
    EXTENSION=$(echo "$1" | tr "[:upper:]" "[:lower:]")
    case $EXTENSION in
        *.jpg | *.jpeg | *.png)
            if [ -x /usr/bin/gthumb ]; then
                CMD=gthumb
            else
                CMD=$BROWSER
            fi
            ;;
        *.ods | *.docx | *.csv) CMD=libreoffice ;;
        *.pdf | *.webm) CMD=$BROWSER ;;
    esac
    if [ "$CMD" = edit ]; then
        [ "$TEST" = -n ] && exit 1
        "$CMD" "$@"
    else
        [ "$TEST" = -n ] && exit 0
        nohup setsid -f "$CMD" "$@" > /dev/null 2>&1
    fi
}

files=( "${@}" )
if [ $# = 0 ]; then
    mapfile -t files < <(fzf)
    open "${files[@]}"
else
    open "$@"
fi
