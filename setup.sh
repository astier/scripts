#!/usr/bin/env sh

install() {
    sudo ln -frs scripts/"$1".sh /usr/local/bin/"$1" &&
        echo Installed: "$1"
}

install bs
install efistub
install pkg
install s
install sl
install wa
install x
