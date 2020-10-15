#!/usr/bin/env sh

target=$1
if [ $# = 0 ]; then
    target=$(fzf)
elif [ ! -f "$1" ]; then
    target=$(fzf --filter="$*" | head -n1)
fi

case $target in
    *.md) markdownlint "$target" ;;
    *.py) pylint "$target" ;;
    *.sh) shellcheck "$target" ;;
    *.tex) chktex -q "$target" ;;
    *.vim) vint -c --enable-neovim "$target" ;;
    *) echo Extension not recognized. ;;
esac

[ ! -f "$1" ] && echo "$target"
