#!/usr/bin/env sh

DIR=~/bin
mkdir -p "$DIR"

link() {
    script=$(echo "$1" | cut -d. -f1)
    ln -frs scripts/"$1" "$DIR/$script" && echo Installed: "$script"
}

link autopen.sh
link bstatus.sh
link cpm.sh
link efistub.sh
link execute.sh
link ffind.sh
link format.sh
link launch.sh
link lint.sh
link netwmicon.sh
link open.sh
link pkg.sh
link sfzf.sh
