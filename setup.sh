#!/usr/bin/env sh

DIR=~/.local/bin
mkdir -p "$DIR"

link() {
    script=$(echo "$1" | cut -d. -f1)
    ln -frs "$1" "$DIR/$script" && echo Installed: "$script"
}

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
link mmrdf.sh
link monitor.sh
link open.sh
link pkg.sh
link preview.sh
link volume.sh
link wal.sh

sudo cp lock.sh /usr/bin/lock && echo Installed: lock
