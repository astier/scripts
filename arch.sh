#!/usr/bin/env sh

# shellcheck disable=SC2164,SC2317

iwctl # Connect to internet

# PARTITIONS
gdisk /dev/nvme0n1
# p1 (size +2G, type ef00), p2

# ENCRYPTION
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 root

# FILESYSTEMS
mkfs.ext4 -L ROOT /dev/mapper/root
mkfs.fat -n BOOT /dev/nvme0n1p1

# MOUNT
mount -L ROOT /mnt
mount -L BOOT --mkdir /mnt/boot

# PROGRAMS
pacstrap -K /mnt \
    alsa-utils \
    arc-solid-gtk-theme \
    base \
    base-devel \
    bash-completion \
    brightnessctl \
    efibootmgr \
    fd \
    firefox \
    fzf \
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
    rclone \
    reflector \
    ripgrep \
    sx \
    sxhkd \
    terminus-font \
    thermald \
    tlp \
    tmux \
    ttf-dejavu \
    ttf-nerd-fonts-symbols \
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
useradd -mG video,wheel user
passwd user
passwd
nvim /etc/pam.d/su # trust and require wheel-group
EDITOR=nvim visudo # give wheel-users permissions
cd /home/user && su - user

# AUR
git clone https://aur.archlinux.org/paru-bin
cd paru-bin && makepkg -i
paru -S \
    alttab-git \
    dashbinsh \
    flat-remix \
    xbanish
cd .. && rm -rf paru-bin

# REPOS - DOWNLOAD
mkdir repos && cd repos
git clone git@github.com:astier/config.git
git clone git@github.com:astier/dmenu.git
git clone git@github.com:astier/scripts.git
git clone git@github.com:astier/st.git
git clone git@github.com:astier/xswm.git

# REPOS - INSTALL
cd config && . shell/exports && ./setup.sh
cd ../dmenu && make install
cd ../scripts && ./setup.sh
cd ../st && make install
cd ../xswm && make install

# PKGBUILDS
cd ../config/pkgbuilds/susu && makepkg -i
exit

# AUTOSTART
systemctl enable \
    fstrim.timer \
    iptables.service \
    iwd.service \
    reflector.timer \
    systemd-resolved.service \
    systemd-timesyncd.service \
    thermald.service \
    tlp.service \
    tty-conf.service
ln -fs /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# BOOT
nvim /etc/mkinitcpio.conf
# HOOKS=(... block encrypt filesystems ...)
mkinitcpio -P
sh repos/scripts/efistub.sh

# REBOOT
exit
umount -R /mnt
poweroff
