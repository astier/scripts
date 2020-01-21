#!/usr/bin/env sh

if [ $# -eq 0 ]; then
    fzf | xargs -r "$EDITOR"
elif [ ! -f "$1" ]; then
    echo File \'"$1"\' doesn\'t exist.
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
        "application/csv") $EDITOR "$@" ;;
        "application/json") $EDITOR "$@" ;;
        "inode/x-empty") $EDITOR "$@" ;;
        "application/pdf") $BROWSER "$@" ;;
        *) echo No association with mimetype: "$mimetype" >&2 ;;
    esac
fi
