#!/usr/bin/env sh

iwctl # Connect to internet
timedatectl set-ntp 1

# PARTITIONS
gdisk /dev/nvme0n1
# p1 +2G
# p2 rest of drive
# p3 34-2047, partition-type: BIOS boot partition (ef02)

# ENCRYPTION
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 root

# FILESYSTEMS
mkfs.ext4 -L ROOT /dev/mapper/root
mkfs.fat  -n BOOT /dev/nvme0n1p1

# MOUNT
mount -L ROOT /mnt
mkdir /mnt/boot
mount -L BOOT /mnt/boot

# PROGRAMS
pacstrap /mnt \
    arc-gtk-theme \
    base \
    bash-completion \
    dunst \
    fakeroot \
    firefox \
    fzf \
    gcc \
    gd \
    git \
    grub \
    intel-ucode \
    iwd \
    linux \
    linux-firmware \
    make \
    man-db \
    neovim \
    noto-fonts-cjk \
    noto-fonts-emoji \
    openssh \
    pkgconf \
    pulsemixer \
    rclone \
    sx \
    sxhkd \
    terminus-font \
    tmux \
    ttf-dejavu \
    ttf-hack-nerd \
    xsel \

# FSTAB
genfstab -L /mnt >> /mnt/etc/fstab
sed -i s/relatime/noatime/ /mnt/etc/fstab

# MISC
arch-chroot /mnt
echo <hostname> > /etc/hostname

# TIME
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock -w

# LANGUAGE
echo LANG=en_US.UTF-8 > /etc/locale.conf
nvim /etc/locale.gen # uncomment en_US.UTF-8 UTF-8
locale-gen

# SILENT BOOT
chattr +i /var/log/lastlog
setterm --blength --cursor on > /etc/issue

# USER
useradd -mG video,wheel <user>
passwd <user>
passwd
# FIX: Copy /root/.gnupg?
nvim /etc/passwd # change root-home-dir from /root to /home/<user>
nvim /etc/pam.d/su   # trust wheel-group and require user to be in wheel-group
nvim /etc/pam.d/su-l # trust wheel-group and require user to be in wheel-group
cd /home/<user> && su <user>

# REPOS - DOWNLOAD
mkdir repos && cd repos
git clone git@github.com:astier/config.git
git clone git@github.com:astier/dmenu.git
git clone git@github.com:astier/scripts.git
git clone git@github.com:astier/sswm.git
git clone git@github.com:astier/st.git
git clone https://aur.archlinux.org/paru-bin

# REPOS - INSTALL
su -c "ln -rs scripts/susu.sh /bin/sudo"
touch /tmp/xorg_started
cd config && . .profile && ./setup.sh
cd ../dmenu && make install
cd ../scripts && ./setup.sh
cd ../sswm && make install
cd ../st && make install

# AUR
cd ../paru-bin && makepkg -is
paru -S \
    alttab-git \
    dashbinsh \
    flat-remix \
    lux \
    mons \
    ttf-amiri \
    xbanish \

# CLEAN
cd .. && rm -r paru-bin
. ~/.profile && clean
exit && rm .bash_*

# AUTOSTART
ln -fs /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
systemctl enable \
    fstrim.timer \
    iptables.service \
    iwd.service \
    systemd-resolved.service \
    systemd-timesyncd.service \
    tty-conf.service \

# MKINITCPIO
nvim /etc/mkinitcpio.conf
# HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block encrypt filesystems fsck)
# COMPRESSION="cat"
# MODULES_DECOMPRESS="yes"
mkinitcpio -P

# BOOT
grub-install /dev/nvme0n1
cp /home/<user>/repos/config/grub /etc/default/
nvim /etc/default/grub # adjust cryptdevice
grub-mkconfig -o /boot/grub/grub.cfg

# REBOOT
exit
umount -R /mnt
reboot
