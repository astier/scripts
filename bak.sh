#!/usr/bin/env sh

. "$XDG_CONFIG_HOME/bakrc"

backup() { sudo rsync -ahiu --delete --info=name --inplace --exclude .~* "$1" "$2" ; }

sudo mkdir -p "$DEST"
sudo cryptsetup open "$DEVICE" "$DEVICE_NAME" -d "$KEY"
sudo mount "$PARTITION" "$DEST"

case $1 in
    -r) backup "$DEST" "$SRC" ;;
    *)  backup "$SRC" "$DEST" ;;
esac

sudo umount "$DEST"
sudo cryptsetup close "$DEVICE_NAME"
sudo rmdir "$DEST"
