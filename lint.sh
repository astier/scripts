#!/usr/bin/env sh

target=$1
if [ $# = 0 ]; then
    target=$(fzf)
elif [ ! -f "$1" ]; then
    target=$(fzf --filter="$*" | head -n1)
fi

case $target in
    *.c) clang --analyze -fno-caret-diagnostics -o /dev/null "$target" ;;
    *.cpp) clang++ --analyze -fno-caret-diagnostics -o /dev/null "$target" ;;
    *.md) markdownlint "$target" ;;
    *.py) pylint "$target" ;;
    *.sh) shellcheck -f gcc "$target" ;;
    *.tex) chktex -q "$target" ;;
    *.vim) vint "$target" ;;
    *) echo Extension not recognized. ;;
esac

[ ! -f "$1" ] && echo "$target"
