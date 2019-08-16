#!/usr/bin/env sh

# apt install git
# mkdir ~/projects && cd ~/projects
# git clone https://github.com/astier/scripts
# sh scripts/scripts/mint.sh

# INSTALL
sudo add-apt-repository ppa:daniruiz/flat-remix
sudo add-apt-repository ppa:neovim-ppa/stable
apt update
apt install arc-theme build-essential deborphan dropbox flat-remix fonts-hack-ttf libx11-dev libxft-dev neovim nodejs tmux xsel yarn

# PROJECTS
cd ~/projects || exit
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/st
cd dotfiles && sh setup.sh
cd ../st && sudo make install clean

# REMOVE, UPDATE, CLEAN
apt purge --auto-remove thunderbird hexchat-common libreoffice-common gnome-calendar gnome-calculator onboard-common rhythmbox-data xplayer-common transmission-common pix-data pix-data simple-scan vim-common ed nano flatpak gucharmap gnome-disk-utility xreader-common redshift xviewer gnome-font-viewer seahorse xed-common tomboy baobab gnome-logs gnome-power-manager gnome-terminal gimp-data mono-runtime-common gnome-orca timeshift
apt update && apt upgrade
apt purge --auto-remove "$(deborphan)"
cd && rm -fr Documents Music Pictures Public Templates Videos .themes .icons .bash_logout

# CONFIGURATI0N
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
sudo bash -c "echo 'vm.swappiness = 0' >> /etc/sysctl.conf"
