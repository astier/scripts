#!/usr/bin/env sh

find() {
    shift
    if [ $# -eq 0 ]; then
        fzf | xargs -r "$EDITOR"
    elif [ ! -f "$1" ]; then
        $EDITOR "$1"
    else
        mimetype=$(file -bL --mime-type "$1")
        mime=$(echo "$mimetype" | cut -d/ -f1)
        case $mime in
            "text") $EDITOR "$@" && return ;;
            "image") $BROWSER "$@" && return ;;
            "video") $PLAYER "$@" && return ;;
            "audio") $PLAYER "$@" && return ;;
        esac
        case $mimetype in
            "application/json") $EDITOR "$@" ;;
            "inode/x-empty") $EDITOR "$@" ;;
            "application/pdf") $BROWSER "$@" ;;
            *) echo No association with mimetype: "$mimetype" >&2 ;;
        esac
    fi
}

open() {
    if [ -r main.py ]; then
        $EDITOR main.py
    elif [ -r main.tex ]; then
        $EDITOR main.tex
    elif [ -r report/main.tex ]; then
        $EDITOR report/main.tex
    elif [ -r setup.sh ]; then
        $EDITOR setup.sh
    elif [ -r config.def.h ]; then
        $EDITOR config.def.h
    else
        echo No appropriate file found.
    fi
}

case $1 in
    -f) find "$@" ;;
    -o) open ;;
    *) echo Invalid arguments. ;;
esac
