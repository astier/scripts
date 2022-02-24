#!/usr/bin/env sh

exec alacritty -e sh -c "fzf $* < /proc/$$/fd/0 > /proc/$$/fd/1"
