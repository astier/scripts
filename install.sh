#!/usr/bin/env bash

BIN_DIR=~/.local/bin
[[ ! -d "$BIN_DIR" ]] && mkdir "$BIN_DIR"

install () {
    ln -frs scripts/"$1".sh "$BIN_DIR"/"$1" &&
    echo Installed: "$1"
}

rm "$BIN_DIR"/*
install b
install dstatus
install x
install u
