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
    mimetype=$(file -bL --mime-type "$1")
    case "$(echo "$mimetype" | cut -d/ -f1)" in
        text) edit "$@" ;;
        image) gthumb "$@" 2>/dev/null & ;;
        video) $BROWSER "$@" & ;;
        audio) $BROWSER "$@" & ;;
        *)
            case $mimetype in
                application/pdf) $BROWSER "$@" & ;;
                application/csv) edit "$@" ;;
                application/json) edit "$@" ;;
                application/octet-stream) edit "$@" ;;
                *document*) libreoffice "$@" 2>/dev/null & ;;
                inode/x-empty) edit "$@" ;;
                *) echo No association with mimetype: "$mimetype" >&2 ;;
            esac
            ;;
    esac
}

if [ $# = 0 ]; then
    open $(fzf)
elif [ ! -f "$1" ]; then
    edit "$@"
else
    open "$@"
fi
