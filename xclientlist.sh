#!/usr/bin/env sh

clients() { xprop -root "$1" | sed "s/$1(WINDOW): window id # //" | sed "s/, /\n/g"; }

case $1 in
    "")
        clients _NET_CLIENT_LIST ;;
    --stack)
        clients _NET_CLIENT_LIST_STACKING ;;
    --last)
        clients _NET_CLIENT_LIST_STACKING | tail -2 | head -1 ;;
    *)
        echo Illegal flag. && exit 1
esac
