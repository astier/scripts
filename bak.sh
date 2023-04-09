#!/usr/bin/env sh

[ ! -x "$(command -v rsync)" ] && echo rsync not on the PATH && exit

TARGET=Documents

SRC=$HOME/$TARGET/
DEST=/mnt/$TARGET

DEVICE=/dev/disk/by-label/$TARGET
MAPPER=/dev/mapper/$TARGET

clean_up() {
  sleep 1 # give rsync some time to terminate
  is_mounted "$DEST" && sudo umount -v "$DEST"
  if is_open "$TARGET"; then
    echo "close: $TARGET"
    sudo cryptsetup close "$TARGET"
  fi
  exit
}
trap clean_up INT HUP TERM EXIT

is_open() { sudo dmsetup ls | grep -q "$1" ; }
is_mounted() { grep -q "$1" /proc/mounts ; }

# DECRYPT
if ! is_open "$TARGET"; then
  echo "open: $DEVICE as $TARGET"
  sudo cryptsetup open "$DEVICE" "$TARGET" -d /root/key
fi

# MOUNT
if ! is_mounted "$DEST"; then
  sudo mount -v "$MAPPER" --mkdir "$DEST" || exit
fi

sudo rsync -ahiv --delete --exclude '.~*' --exclude 'lost+found/' --exclude '.Trash-1000/' "$SRC" "$DEST"
