#!/usr/bin/env sh

# mmrdf - Make/Move/Rename-Dir/File

[ $# = 0 ] && return

if [ -e "$1" ]; then
    for last; do true; done
    [ ! -d "$last" ] && mkdir -pv "$last"
    mv -iv "$@"
else
    for arg in "$@"; do
        case $arg in
            */) mkdir -pv "$arg" ;;
            *)
                dir=$(dirname "$arg")
                [ ! -d "$dir" ] && mkdir -pv "$dir"
                touch "$arg"
                ;;
        esac
    done
fi
