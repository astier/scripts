# ARCH
(ctrl-alt-t) # open crosh
vmc destroy termina
vmc start termina
lxc launch images:archlinux/current penguin
lxc exec penguin bash

# LOCALE
vi /etc/locale.gen # uncomment lines
#en_US.UTF-8 UTF-8
locale-gen

# PACMAN
vi /etc/pacman.conf # uncomment lines
#Color
#VerbosePkgLists

# INSTALL
pacman -Syu
  arc-solid-gtk-theme \
  base-devel \
  bash-completion \
  fd \
  fzf \
  git \
  neovim \
  openssh \
  reflector \
  ripgrep \
  tmux \
  ttf-dejavu \
  wl-clipboard

# UNINSTALL
pacman -Rns \
  dhcpcd \
  inetutils \
  logrotate \
  man-pages \
  nano \
  netctl \
  sysfsutils \
  vi

# INTERNET
mkdir /etc/systemd/system/systemd-networkd.service.d
nvim /etc/systemd/system/systemd-networkd.service.d/lxc.conf
# [Service]
# BindReadOnlyPaths=/sys

# USER
grep 1000:1000 /etc/passwd # print username (alarm usually)
groupmod -n user alarm
usermod -d /home/user -l user -m -c user alarm
usermod -aG wheel user
passwd user
passwd
nvim /etc/pam.d/su # trust and require wheel-group
EDITOR=nvim visudo
# %wheel ALL=(ALL) NOPASSWD ALL
# Defaults editor=/usr/bin/nvim
exit
lxc console penguin

# AUR
git clone https://aur.archlinux.org/paru-bin
cd paru-bin && makepkg -i
paru -S cros-container-guest-tools-git dashbinsh
cp -r /etc/skel/.config/pulse ~/.config
systemctl enable --user sommelier{,-x}@{0,1}.service
cd .. && rm -rf paru-bin

# REPOS
mkdir repos && cd repos
git clone git@github.com:astier/config.git
git clone git@github.com:astier/scripts.git
cd config && . shell/exports && ./setup.sh
cd pkgbuilds/susu && makepkg -i
cd ../scripts && ./setup.sh
systemctl enable iptables.service reflector.timer

# CLEAN
cd && rm .bash_logout .bash_profile .lesshst
(ctrl-a-q) # exit arch
exit # exit termina
vmc stop termina
