#!/usr/bin/env sh

case $1 in
    -h)
        echo "launch [term|tty|fzf]"
        ;;
    term)
        spawn "$TERMINAL" -n launcher -g 32x8 -e launch fzf
        ;;
    tty)
        spawn tmux -L tty popup -E launch fzf
        chvt 2
        ;;
    fzf|*)
        cmd=$(printf "%s" "$PATH" | xargs -d: -I{} find -L {} -maxdepth 1 -mindepth 1 -executable -type f -printf "%P\n" | fzf)
        [ -n "$cmd" ] && spawn "$cmd" || exit
        ;;
esac

