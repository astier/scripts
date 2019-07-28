#!/usr/bin/env sh

# INSTALL
sudo add-apt-repository ppa:daniruiz/flat-remix
sudo add-apt-repository ppa:neovim-ppa/stable
apt update
apt install arc-theme dropbox flat-remix git neovim nodejs xsel tmux deborphan build-essential libx11-dev libxft-dev yarn

# REMOVE
apt purge --auto-remove thunderbird hexchat-common libreoffice-common gnome-calendar gnome-calculator onboard-common rhythmbox-data xplayer-common transmission-common pix-data pix-data simple-scan vim-common ed nano flatpak gucharmap gnome-disk-utility xreader-common redshift xviewer gnome-font-viewer seahorse xed-common tomboy baobab gnome-logs gnome-power-manager gimp-data mono-runtime-common gnome-orca gnome-terminal-data timeshift dmz-cursor-theme
apt purge --auto-remove "$(deborphan)"
rm -fr Documents Music Pictures Public Templates Videos .themes .icons .bash_logout

# PROJECTS
mkdir ~/projects && cd ~/projects || exit
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/scripts
git clone https://github.com/astier/st
cd dotfiles && sh setup.sh
cd ../scripts && sh setup.sh
cd ../st && sh setup.sh

# CONFIGURATI0N
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
sudo bash -c "echo 'vm.swappiness = 0' >> /etc/sysctl.conf"

# UPDATE
apt update
apt upgrade
apt purge --auto-remove "$(deborphan)"
