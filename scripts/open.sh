#!/usr/bin/env sh

if [ $# -eq 0 ]; then
    ffind -type f
elif [ ! -f "$1" ]; then
    ffind -type f | sfzf "$@" | xargs -r open
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
                *document*) libreoffice "$@" 2>/dev/null & ;;
                inode/x-empty) $EDITOR "$@" ;;
                *) echo No association with mimetype: "$mimetype" >&2 ;;
            esac
            ;;
    esac
fi
