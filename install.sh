#!/usr/bin/env bash

BIN_DIR=~/.local/bin
[[ ! -d "$BIN_DIR" ]] && mkdir $BIN_DIR

install () {
    ln -rs scripts/"$1".sh $BIN_DIR/"$TARGET" &&
    echo Installed: "$1"
}

rm "$BIN_DIR"/*
install dstatus
install open
install scr
install b
