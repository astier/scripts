#!/usr/bin/env sh

[ ! -x "$(command -v rclone)" ] && echo rclone not on the PATH && exit
exec rclone sync -Pv --track-renames "$@"
