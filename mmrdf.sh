#!/usr/bin/env sh

# mmrdf - Make/Move/Rename-Dir/File

[ $# = 0 ] && return

if [ -e "$1" ]; then
    mv -iv "$@"
else
    for arg in "$@"; do
        case $arg in
            */) mkdir -p "$arg" ;;
            *)
                dir=$(dirname "$arg")
                [ ! -d "$dir" ] && mkdir -p "$dir"
                touch "$arg"
                ;;
        esac
    done
fi
