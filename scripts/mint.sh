#!/usr/bin/env sh

# REMOVE
apt purge --auto-remove thunderbird hexchat-common libreoffice-common gnome-calendar gnome-calculator onboard-common rhythmbox-data xplayer-common transmission-common pix-data pix-data simple-scan vim-common ed nano flatpak gucharmap gnome-disk-utility xreader-common redshift xviewer gnome-font-viewer seahorse xed-common tomboy baobab gnome-logs gnome-power-manager

# PPAs'
sudo add-apt-repository ppa:daniruiz/flat-remix
sudo add-apt-repository ppa:neovim-ppa/stable
apt update

# INSTALL
apt install arc-theme dropbox eog evince flat-remix git neovim snapd
snapd install code --classic
