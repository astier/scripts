#!/usr/bin/env sh

DIR_HOME=~/.local/bin
mkdir -p "$DIR_HOME"
link_home() {
    script=$(echo "$1" | cut -d. -f1)
    ln -frs "$1" "$DIR_HOME/$script" && echo Installed: "$script"
}

DIR_USR=/usr/local/bin
mkdir -p "$DIR_USR"
link_usr() {
    script=$(echo "$1" | cut -d. -f1)
    sudo ln -frs "$1" "$DIR_USR/$script" && echo Installed: "$script"
}

link_home bak.sh
link_home bstatus.sh
link_home cpm.sh
link_home efistub.sh
link_home execute.sh
link_home ffind.sh
link_home format.sh
link_home ggrep.sh
link_home iwltm.sh
link_home launch.sh
link_home lint.sh
link_home ls-dirs.sh
link_home ls-files.sh
link_home ls-ignored.sh
link_home memlog.sh
link_home mmrdf.sh
link_home open.sh
link_home pkg.sh
link_home preview.sh
link_home root.sh
link_home rrclone.sh
link_home sfzf.sh
link_home spawn.sh
link_home susu.sh
link_home update.sh
link_home volume.sh
link_home wal.sh
link_home xclientlist.sh

link_usr brightness.sh
link_usr lock.sh
link_usr monitor.sh
