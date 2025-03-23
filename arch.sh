#!/usr/bin/env sh

# shellcheck disable=SC2164,SC2317

iwctl # Connect to internet

# PARTITIONS
gdisk /dev/nvme0n1
# p1 (size +1G, type ef00), p2

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
    reflector \
    ripgrep \
    sx \
    sxhkd \
    terminus-font \
    tmux \
    ttf-dejavu \
    ttf-dejavu-nerd \
    xsel

# FSTAB
genfstab -L /mnt >> /mnt/etc/fstab
sed -i s/relatime/noatime/ /mnt/etc/fstab

# MISC
arch-chroot /mnt
echo "<hostname>" > /etc/hostname
nvim /etc/pacman.conf # Color, VerbosePkgLists, ParallelDownloads

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
EDITOR=nvim visudo # Give wheel-group permissions
cd /home/user && su - user

# GNUPG
mkdir -p .local/share/gnupg
chmod 700 .local/share/gnupg
gpg --homedir .local/share/gnupg --list-keys

# AUR
git clone https://aur.archlinux.org/paru-bin
cd paru-bin && makepkg -i
paru -S \
    alttab \
    dashbinsh
sudo find /usr/share/themes -type f -exec sed -i 's/#2f343f/#2e3440/g' {} +
cd && rm -rf paru-bin

# REPOS - DOWNLOAD
mkdir repos && cd repos
git clone git@github.com:astier/config
git clone git@github.com:astier/dmenu
git clone git@github.com:astier/scripts
git clone git@github.com:astier/st
git clone git@github.com:astier/xhidecursor
git clone git@github.com:astier/xswm

# REPOS - INSTALL
cd config && . shell/exports && ./setup.sh
cd ../dmenu && make install
cd ../scripts && ./setup.sh
cd ../st && make install
cd ../xhidecursor && sudo make install
cd ../xswm && sudo make install
exit

# AUTOSTART
systemctl enable \
    fstrim.timer \
    iptables.service \
    iwd.service \
    reflector.timer \
    systemd-resolved.service \
    systemd-timesyncd.service \
    ttyrc.service

# BOOT
nvim /etc/mkinitcpio.conf
# HOOKS=(... block encrypt filesystems ...)
mkinitcpio -P
sh repos/scripts/efistub.sh

# REBOOT
exit
umount -R /mnt
reboot

# FINISH
sudo ln -fs /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
iwctl # Connect to internet
sudo pacman -Rns efibootmgr paru-bin-debug
rm .bash_* .lesshst
paru -S flat-remix # Takes a long time
# Try intel-undervolt, thermald
