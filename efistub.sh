#!/usr/bin/env sh

doas efibootmgr -Bqb0
doas efibootmgr -cqd /dev/nvme0n1 -p1 -L arch -l /vmlinuz-linux -u 'initrd=\intel-ucode.img initrd=\initramfs-linux.img cryptdevice=/dev/nvme0n1p2:root cryptkey=/dev/sda:17408:512 root=LABEL=ROOT rw loglevel=2 udev.log_priority=3 nowatchdog module_blacklist=iTCO_vendor_support,iTCO_wdt vt.global_cursor_default=0'
efibootmgr
