#!/usr/bin/env sh

[ ! -x "$(command -v rsync)" ] && echo rsync not on the PATH && exit

. "$XDG_CONFIG_HOME/bakrc"

backup() { sudo rsync -ahiuc --delete --info=name --inplace --exclude .~* "$1" "$2" ; }

sudo mkdir -p "$DEST"
sudo cryptsetup open "$DEVICE" "$DEVICE_NAME" -d "$KEY"
sudo mount "$PARTITION" "$DEST" || exit

case $1 in
    -r) backup "$DEST" "$SRC" ;;
    *)  backup "$SRC" "$DEST" ;;
esac

sudo umount "$DEST"
sudo cryptsetup close "$DEVICE_NAME"
sudo rmdir "$DEST"
