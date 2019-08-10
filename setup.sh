#!/usr/bin/env sh

install() {
    sudo ln -frs scripts/"$1".sh /usr/local/bin/"$1" &&
        echo Installed: "$1"
}

install bstatus
install efistub
install i
install r
install tstatus
install x
