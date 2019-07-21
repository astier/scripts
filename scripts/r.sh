#!/usr/bin/env sh

if [ $# -eq 0 ]; then
	pacman -Qetq | fzf -m --preview 'pacman -Qi {1}' > /tmp/r
	xargs -ra /tmp/r sudo pacman -Rns
else
	sudo pacman -Rns "$@"
fi
