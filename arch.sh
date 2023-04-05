#!/usr/bin/env sh

# shellcheck disable=SC2164,SC2317

iwctl # Connect to internet
timedatectl set-ntp 1

# PARTITIONS
gdisk /dev/nvme0n1
# p1 +1G
# p2 rest of drive
# p3 34-2047, partition-type: BIOS boot partition (ef02)

# ENCRYPTION
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 root

# FILESYSTEMS
mkfs.ext4 -L ROOT /dev/mapper/root
mkfs.fat -n BOOT /dev/nvme0n1p1

# MOUNT
mount -L ROOT /mnt
mkdir /mnt/boot
mount -L BOOT /mnt/boot
genfstab -L /mnt >> /mnt/etc/fstab

# PROGRAMS
pacstrap /mnt \
    arc-solid-gtk-theme \
    base \
    base-devel \
    bash-completion \
    fd \
    firefox \
    fzf \
    gd \
    git \
    grub \
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
    tmux \
    ttf-dejavu \
    ttf-hack-nerd \
    xsel

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
EDITOR=nvim visudo # %wheel ALL=(ALL:ALL) NOPASSWD: ALL
cd /home/"<user>" && su - "<user>"

# AUR
git clone https://aur.archlinux.org/paru-bin
cd paru-bin && makepkg -is
paru -S \
    alttab-git \
    dashbinsh \
    flat-remix \
    lux \
    mons \
    ttf-amiri \
    xbanish

# REPOS
mkdir repos && cd repos
git clone git@github.com:astier/config.git
git clone git@github.com:astier/scripts.git
git clone git@github.com:astier/sswm.git
git clone git@github.com:astier/st.git
cd config && . shell/exports && ./setup.sh
cd ../scripts && ./setup.sh
cd ../sswm && make install
cd ../st && make install
curl -fLo "XDG_DATA_HOME/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# CLEAN
cd
rm -r paru-bin .bash_*
clean
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
# HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block encrypt filesystems fsck)
mkinitcpio -P

# BOOT
grub-install /dev/nvme0n1
cp /home/"<user>"/repos/config/grub /etc/default/
nvim /etc/default/grub # adjust cryptdevice
grub-mkconfig -o /boot/grub/grub.cfg

# REBOOT
exit
umount -R /mnt
reboot
