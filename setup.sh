#!/usr/bin/env sh

link() {
    install_name=$(echo "$1" | cut -d. -f1)
    sudo ln -frs scripts/"$1" /usr/local/bin/"$install_name" &&
        echo Installed: "$1"
}

link autopen.sh
link bstatus.sh
link cpm.sh
link efistub.sh
link execute.sh
link format.sh
link launch.sh
link lint.sh
link netwmicon.sh
link open.sh
link pkg.sh
link sfzf.sh
link spawn.py
