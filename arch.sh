#!/usr/bin/env sh

iwctl # connect to internet
timedatectl set-ntp 1

# PARTITION
fdisk /dev/nvme0n1 # p1 +256M, p2, p3 34-2047 BIOS boot
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 root
mkfs.ext4 -L ROOT /dev/mapper/root
mkfs.fat -n BOOT /dev/nvme0n1p1

# MOUNT
mount -L ROOT /mnt
mkdir /mnt/boot
mount -L BOOT /mnt/boot

# INSTALL
pacstrap /mnt \
    arc-gtk-theme \
    autorandr \
    base \
    bash-completion \
    fakeroot \
    firefox \
    fzf \
    gcc \
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
    opendoas \
    openssh \
    patch \
    pkgconf \
    pulsemixer \
    rsync \
    sx \
    sxhkd \
    terminus-font \
    tmux \
    ttf-dejavu \
    xsel \

# FSTAB
genfstab -L /mnt >> /mnt/etc/fstab
sed -i s/relatime/noatime/ /mnt/etc/fstab

# MISC
arch-chroot /mnt
echo <hostname> > /etc/hostname
ln -s /bin/doas /bin/sudo

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
nvim /etc/passwd # change root-home-dir from /root to /home/<user>
echo permit nopass keepenv :wheel >> /etc/doas.conf
echo permit nopass keepenv root >> /etc/doas.conf

# REPOS - DOWNLOAD
cd /home/<user> && su <user>
mkdir repos && cd repos
git clone git@github.com:astier/config.git
git clone git@github.com:astier/scripts.git
git clone git@github.com:astier/sswm.git
git clone git@github.com:astier/st.git
git clone https://aur.archlinux.org/paru-bin

# REPOS - INSTALL
touch /tmp/xorg_started
cd config && . .profile && ./setup.sh
cd ../scripts && ./setup.sh
cd ../sswm && make install
cd ../st && make install
cd ../paru-bin && makepkg -is
paru -S \
    alttab-git \
    dashbinsh \
    flat-remix \
    libxft-bgra \
    lux \
    nerd-fonts-hack \
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
# HOOKS=(base udev autodetect modconf block keyboard consolefont encrypt filesystems fsck)
mkinitcpio -P

# BOOT
grub-install /dev/nvme0n1
cp /home/<user>/repos/config/grub /etc/default/grub
nvim /etc/default/grub # adjust cryptdevice
grub-mkconfig -o /boot/grub/grub.cfg

# REBOOT
exit
umount -R /mnt
reboot
