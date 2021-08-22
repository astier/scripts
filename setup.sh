#!/usr/bin/env sh

DIR=~/.local/bin
mkdir -p "$DIR"

link() {
    script=$(echo "$1" | cut -d. -f1)
    ln -frs "$1" "$DIR/$script" && echo Installed: "$script"
}

link autopen.sh
link bak.sh
link bstatus.sh
link cpm.sh
link efistub.sh
link execute.sh
link ffind.sh
link format.sh
link launch.sh
link lint.sh
link memlog.sh
link menu.sh
link mmrdf.sh
link monitor.sh
link open.sh
link pkg.sh
link preview.sh
link wal.sh
