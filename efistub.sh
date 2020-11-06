#!/usr/bin/env sh

sudo efibootmgr -Bqb0
sudo efibootmgr -cqd /dev/nvme0n1 -p1 -L arch -l /vmlinuz-linux-lts -u 'initrd=\intel-ucode.img initrd=\initramfs-linux-lts.img cryptdevice=/dev/nvme0n1p2:root cryptkey=/dev/sda:offset:size root=LABEL=ROOT rw loglevel=2 udev.log_priority=3 nowatchdog module_blacklist=iTCO_vendor_support,iTCO_wdt vt.global_cursor_default=0'
efibootmgr
