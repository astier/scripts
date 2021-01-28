#!/usr/bin/env sh

install() {
    shift
    if [ $# -eq 0 ]; then
        pacman -Slq | fzf -m --preview 'pacman -Si {1}' > /tmp/pkg
        xargs -ra /tmp/pkg doas pacman -S
    else
        doas pacman -S "$@"
    fi
}

remove() {
    shift
    if [ $# -eq 0 ]; then
        pacman -Qettq | fzf -m --preview 'pacman -Qi {1}' > /tmp/pkg
        xargs -ra /tmp/pkg doas pacman -Rns
    else
        doas pacman -Rns "$@"
    fi
}

case $1 in
    -i) install "$@" ;;
    -r) remove "$@" ;;
    *) echo Invalid arguments. ;;
esac
