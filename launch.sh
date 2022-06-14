#!/usr/bin/env sh

spawn() { nohup setsid -f "$@" > /dev/null 2>&1 ; }

case $1 in
    -h)
        echo "launch [term|tty|fzf]"
        ;;
    term)
        spawn "$TERMINAL" -e launch fzf
        ;;
    tty)
        sudo chvt 2
        spawn tmux -L tty popup -E launch fzf
        ;;
    fzf|*)
        spawn "$(printf "%s" "$PATH" | xargs -d: -I{} find -L {} -maxdepth 1 \
            -mindepth 1 -executable -type f -printf "%P\n" | sort -u | fzf)"
        ;;
esac

