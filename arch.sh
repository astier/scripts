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
    fakeroot \
    firefox \
    fzf \
    gcc \
    gd \
    gdm \
    git \
    gnome-control-center \
    gnome-tweaks \
    grub \
    intel-ucode \
    linux \
    linux-firmware \
    make \
    man-db \
    neovim \
    networkmanager \
    noto-fonts-cjk \
    noto-fonts-emoji \
    openssh \
    pkgconf \
    rclone \
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

# LOCALE
nvim /etc/locale.gen # uncomment de_DE.UTF-8 UTF-8 and en_US.UTF-8 UTF-8
locale-gen

# SILENT BOOT
chattr +i /var/log/lastlog
setterm --blength --cursor on > /etc/issue

# USER
useradd -mG wheel <user>
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
git clone git@github.com:astier/scripts.git
git clone git@github.com:astier/st.git
git clone https://aur.archlinux.org/paru-bin

# REPOS - INSTALL
su -c "ln -rs scripts/susu.sh /bin/sudo"
touch /tmp/xorg_started
cd config && . .profile && ./setup.sh
cd ../scripts && ./setup.sh
cd ../st && make install

# AUR
cd ../paru-bin && makepkg -is
paru -S \
    dashbinsh \
    flat-remix \
    gnome-browser-connector \
    ttf-amiri \
    xbanish \

# GNOME - CONFIG
dconf write /org/gnome/mutter/draggable-border-width 0
gsettings set org.gnome.desktop.interface overlay-scrolling false
gsettings set org.gnome.mutter focus-change-on-pointer-rest false
gsettings set org.gnome.SessionManager logout-prompt false

# CLEAN
cd .. && rm -r paru-bin
. ~/.profile && clean
exit && rm .bash_*

# AUTOSTART
ln -fs /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
# TODO: try setting timedatectl-ntp otherwise check if timedatectl-ntp is set after reboot
systemctl enable \
    fstrim.timer \
    gdm.service \
    iptables.service \
    NetworkManager.service \
    systemd-resolved.service \
    tty-conf.service \

# MKINITCPIO
nvim /etc/mkinitcpio.conf
# MODULES=(i915)
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
