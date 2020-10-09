#!/usr/bin/env sh

mimetype=$(file -bL --mime-type "$1")
case "$(echo "$mimetype" | cut -d/ -f1)" in
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
