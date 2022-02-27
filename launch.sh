#!/usr/bin/env sh

spawn() { exec setsid -f "$@" > /dev/null 2>&1 ; }

launch_fzf() {
    cmd="$(printf "%s" "$PATH" | xargs -d: -I{} find -L {} -maxdepth 1 -mindepth 1 -executable -type f -printf "%P\n" | sort -u | fzf)"
    [ -n "$cmd" ] && exec setsid -f "$cmd" > /dev/null 2>&1
}

case $1 in
    term)
        spawn alacritty -e launch
        ;;
    tty)
        sudo chvt 2
        spawn tmux -L tty popup -E launch
        ;;
    *)
        launch_fzf
        ;;
esac

