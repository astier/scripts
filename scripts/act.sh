#!/usr/bin/env sh

action() {
    if [ -r main.py ]; then
        $EDITOR main.py
    elif [ -r main.tex ]; then
        $EDITOR main.tex
    elif [ -r setup.sh ]; then
        $EDITOR setup.sh
    elif [ -r config.def.h ]; then
        $EDITOR config.def.h
    else
        echo No appropriate file found.
    fi
}

execute() {
    shift
    if [ $# -eq 0 ]; then
        if [ -f main.py ]; then
            python main.py
        elif [ -f setup.sh ]; then
            sh setup.sh
        elif [ -f Makefile ]; then
            [ -f config.h ] && rm -f config.h
            sudo make install clean
        else
            echo No appropriate action can be applied.
        fi
    else
        for last; do true; done
        case $last in
            *.py) python "$@" ;;
            *.sh) sh "$@" ;;
            *.tar.gz) tar -xzf "$@" ;;
            *.zip) unzip "$@" ;;
            *) echo Extension not recognized. ;;
        esac
    fi
}

open() {
    shift
    if [ $# -eq 0 ]; then
        fzf-tmux | xargs -r "$EDITOR"
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

case $1 in
    "") action ;;
    -e) execute "$@" ;;
    -o) open "$@" ;;
    *) echo Invalid arguments. ;;
esac
