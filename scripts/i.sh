#!/usr/bin/env sh

if [ $# -eq 0 ]; then
	pacman -Slq | fzf -m --preview 'pacman -Si {1}' > /tmp/i
	xargs -ra /tmp/i sudo pacman -S
else
	sudo pacman -S "$@"
fi
