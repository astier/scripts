#!/usr/bin/env sh

sudo efibootmgr -Bqb0
sudo efibootmgr -cd /dev/nvme0n1 -p1 -L "Arch Linux" -l /vmlinuz-linux -u "\
    initrd=\\intel-ucode.img \
    initrd=\\initramfs-linux.img \
    cryptdevice=/dev/nvme0n1p2:root:allow-discards \
    root=LABEL=root rw \
    loglevel=2 \
    udev.log_priority=3 \
    vt.global_cursor_default=0 \
    vt.cur_default=6 \
    modprobe.blacklist=iTCO_vendor_support,iTCO_wdt \
    module_blacklist=iTCO_vendor_support,iTCO_wdt \
    nowatchdog \
    mitigations=off \
"
