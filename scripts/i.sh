#!/usr/bin/env sh

if [ $# -eq 0 ]; then
	pacman -Slq | fzf -m --preview 'pacman -Si {1}' > /tmp/i
	sudo xargs -ra /tmp/i pacman -S
else
	sudo pacman -S "$@"
fi
