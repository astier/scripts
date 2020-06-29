#!/usr/bin/env sh

if [ $# -eq 0 ]; then
    fzf | xargs -r open
elif [ ! -f "$1" ]; then
    echo File \'"$1"\' doesn\'t exist.
else
    mimetype=$(file -bL --mime-type "$1")
    mime=$(echo "$mimetype" | cut -d/ -f1)
    case $mime in
        text) $EDITOR "$@" ;;
        video) mpv "$@" ;;
        audio) mpv "$@" ;;
        image) eog "$@" ;;
        *)
            case $mimetype in
                application/pdf) $BROWSER "$@" & ;;
                application/csv) $EDITOR "$@" ;;
                application/json) $EDITOR "$@" ;;
                application/octet-stream) $EDITOR "$@" ;;
                *opendocument*) libreoffice "$@" 2>/dev/null & ;;
                inode/x-empty) $EDITOR "$@" ;;
                *) echo No association with mimetype: "$mimetype" >&2 ;;
            esac
            ;;
    esac
fi
