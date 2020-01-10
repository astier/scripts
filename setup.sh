#!/usr/bin/env sh

install() {
    sudo ln -frs scripts/"$1".sh /usr/local/bin/"$1" &&
        echo Installed: "$1"
}

install act
install bst
install cpm
install efs
install execute
install format
install lint
install pkg
install sys
install wal
