#!/usr/bin/env sh

install() {
    install_name=$(echo "$1" | cut -d. -f1)
    sudo ln -frs scripts/"$1" /usr/local/bin/"$install_name" &&
        echo Installed: "$1"
}

install autopen.sh
install bstatus.sh
install cpm.sh
install efistub.sh
install execute.sh
install format.sh
install launch.sh
install lint.sh
install open.sh
install pkg.sh
install spawn.py
install wal.sh
