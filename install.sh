#!/usr/bin/env bash

install() {
	sudo ln -frs scripts/"$1".sh /usr/local/bin/"$1" &&
		echo Installed: "$1"
}

install b
install i
install x
install u
