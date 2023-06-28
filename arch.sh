#!/usr/bin/env sh

# shellcheck disable=SC2164,SC2317

iwctl # Connect to internet

# PARTITIONS
gdisk /dev/nvme0n1
# p1 +2G, p2 rest

# ENCRYPTION
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 root

# FILESYSTEMS
mkfs.ext4 -L root /dev/mapper/root
mkfs.fat -n boot /dev/nvme0n1p1

# MOUNT
mount -L root /mnt
mount -L boot --mkdir /mnt/boot

# PROGRAMS
pacstrap -K /mnt \
    arc-solid-gtk-theme \
    base \
    base-devel \
    bash-completion \
    efibootmgr \
    fd \
    firefox \
    fzf \
    gd \
    git \
    intel-media-driver \
    intel-ucode \
    iwd \
    linux \
    linux-firmware \
    man-db \
    neovim \
    noto-fonts-cjk \
    noto-fonts-emoji \
    openssh \
    pipewire-pulse \
    pulsemixer \
    reflector \
    ripgrep \
    rsync \
    sx \
    sxhkd \
    terminus-font \
    tmux \
    ttf-dejavu \
    ttf-hack-nerd \
    xsel

# FSTAB
genfstab -L /mnt >> /mnt/etc/fstab
sed -i s/relatime/noatime/ /mnt/etc/fstab

# MISC
arch-chroot /mnt
echo "<hostname>" > /etc/hostname

# TIME
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock -w

# LOCALE
nvim /etc/locale.gen # uncomment en_US.UTF-8 UTF-8
locale-gen

# SILENT BOOT
chattr +i /var/log/lastlog
setterm --blength --cursor on > /etc/issue

# USER
useradd -mG video,wheel "<user>"
passwd "<user>"
passwd
EDITOR=nvim visudo
# %wheel ALL=(ALL:ALL) NOPASSWD: ALL
# Defaults editor=/usr/bin/nvim
cd /home/"<user>" && su - "<user>"

# REPOS - DOWNLOAD
mkdir repos && cd repos
git clone git@github.com:astier/config.git
git clone git@github.com:astier/dmenu.git
git clone git@github.com:astier/scripts.git
git clone git@github.com:astier/sswm.git
git clone git@github.com:astier/st.git
git clone https://aur.archlinux.org/paru-bin

# REPOS - AUR
cd paru-bin && makepkg -is
paru -S \
    alttab-git \
    dashbinsh \
    flat-remix \
    lux \
    mons \
    ttf-amiri \
    xbanish

# REPOS - CUSTOM
cd ../config && . shell/exports && ./setup.sh
cd ../dmenu && make install
cd ../scripts && ./setup.sh
cd ../sswm && make install
cd ../st && make install
exit

# AUTOSTART
ln -fs /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
# TODO: try setting timedatectl-ntp otherwise check if timedatectl-ntp is set after reboot
systemctl enable \
    fstrim.timer \
    iptables.service \
    iwd.service \
    systemd-resolved.service \
    systemd-timesyncd.service \
    tty-conf.service

# MKINITCPIO
nvim /etc/mkinitcpio.conf
# HOOKS=(... block encrypt filesystems ...)
mkinitcpio -P

# BOOT
# TODO: secure-boot (+ systemd-boot)
sh /mnt/home/"<user>"/repos/scripts/efistub.sh

# REBOOT
exit
umount -R /mnt
reboot
