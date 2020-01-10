#!/usr/bin/env sh

install() {
    sudo ln -frs scripts/"$1".sh /usr/local/bin/"$1" &&
        echo Installed: "$1"
}

install autopen
install bst
install cpm
install efistub
install execute
install format
install lint
install open
install pkg
install sys
install wal
