#!/usr/bin/env bash

SCR_DIR="$(pwd)"
BIN_DIR=~/.local/bin/
[[ ! -d "$BIN_DIR" ]] && mkdir $BIN_DIR

install () {
    TARGET=$1
    ln -fs "$SCR_DIR"/scripts/"$TARGET".sh $BIN_DIR/"$TARGET" &&
    echo Installed: "$TARGET"
}

install dstatus
install open
install scr
install bgm
