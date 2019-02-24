#!/usr/bin/env bash

# Synchronize git-projects

cd ~/Projects/ || exit

update () {
	cd "$1" || exit
	echo "Update $1"
	git pull && git push
	cd ..
	echo
}

update arch-installer
update dmenu
update dotfiles
update dwm
update scripts
update st
