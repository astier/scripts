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
    case $1 in
        *.jpg | *.JPG | *.png) gthumb "$@" ;;
        *.ods) libreoffice "$@" 2> /dev/null ;;
        *.pdf) $BROWSER "$@" ;;
        *) edit "$@" ;;
    esac
}

if [ $# = 0 ]; then
    open $(fzf)
else
    open "$@"
fi
