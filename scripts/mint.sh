#!/usr/bin/env sh

# REMOVE
apt purge --auto-remove thunderbird hexchat-common libreoffice-common gnome-calendar gnome-calculator onboard-common rhythmbox-data xplayer-common transmission-common pix-data pix-data simple-scan vim-common ed nano flatpak gucharmap gnome-disk-utility xreader-common redshift xviewer gnome-font-viewer seahorse xed-common tomboy baobab gnome-logs gnome-power-manager gimp-data

# INSTALL
sudo add-apt-repository ppa:daniruiz/flat-remix
sudo add-apt-repository ppa:neovim-ppa/stable
apt update
apt install arc-theme build-essential dropbox flat-remix git neovim nodejs tmux xsel

# PROJECTS
mkdir ~/projects && cd ~/projects
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/scripts
cd dotfiles && sh setup.sh
cd ../scripts && sh setup.sh
cd ../st && sudo make install clean

# CONFIGURATI0N
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
sudo ln /usr/local/bin/st /usr/bin/xterm
