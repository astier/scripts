#!/usr/bin/env sh

[ ! -f "$1" ] && echo File "$1" does not exist. && exit

is_git_rep="$(git rev-parse --is-inside-work-tree 2> /dev/null)"
[ "$is_git_rep" = "true" ] && git diff --check

case $1 in
    *.py) pylint "$1" ;;
    *.sh) shellcheck "$1" ;;
    *.tex) chktex -q "$1" ;;
    *.vim) vint -c --enable-neovim "$1" ;;
    *) echo Extension not recognized. ;;
esac
