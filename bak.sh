#!/usr/bin/env sh

. "$XDG_CONFIG_HOME/bakrc"

sudo mkdir -p "$DEST"
sudo cryptsetup open "$DEVICE" "$DEVICE_NAME" -d "$KEY"
sudo mount "$PARTITION" "$DEST" \
    && sudo rsync -ahiu --delete --info=name --inplace --exclude .~* "$SRC" "$DEST"
sudo umount "$DEST"
sudo cryptsetup close "$DEVICE_NAME"
sudo rmdir "$DEST"
