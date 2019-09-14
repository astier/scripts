#!/usr/bin/env sh

# Update sources and install kernel
# apt install git
# mkdir ~/projects && cd ~/projects
# git clone https://github.com/astier/scripts
# sh scripts/scripts/mint.sh

# INSTALL
sudo add-apt-repository ppa:daniruiz/flat-remix
sudo add-apt-repository ppa:neovim-ppa/stable
apt update
apt install arc-theme build-essential deborphan dropbox ffmpeg flat-remix fonts-hack-ttf herbstluftmw libx11-dev libxft-dev neovim nodejs pulsemixer rofi sxhkd tmux xsel yarn

# PROJECTS
cd ~/projects || exit
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/st
cd dotfiles && sh setup.sh
cd ../scripts && sh setup.sh
cd ../st && sudo make install clean

# REMOVE, UPDATE, CLEAN
apt purge --auto-remove thunderbird hexchat-common libreoffice-common gnome-calendar gnome-calculator onboard-common rhythmbox-data xplayer-common transmission-common pix-data pix-data simple-scan vim-common ed nano flatpak gucharmap gnome-disk-utility xreader-common redshift xviewer gnome-font-viewer seahorse xed-common tomboy baobab gnome-logs gnome-power-manager gnome-terminal gimp-data mono-runtime-common gnome-orca timeshift
apt purge --auto-remove "$(deborphan)"
apt update && apt upgrade
cd && rm -fr Documents Music Pictures Public Templates Videos .themes .icons .bash_logout .gtkrc-xfce .gtkrc-2.0
cd ~/.config && rm -fr goa-1.0 hexchat caja

# CONFIGURATI0N
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
sudo bash -c "echo 'vm.swappiness = 0' >> /etc/sysctl.conf"
