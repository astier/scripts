#!/usr/bin/env sh

# INSTALL
sudo add-apt-repository ppa:daniruiz/flat-remix
sudo add-apt-repository ppa:neovim-ppa/stable
apt update
apt install arc-theme deborphan dropbox flat-remix git neovim nodejs tmux xsel yarn

# PROJECTS
mkdir ~/projects && cd ~/projects || exit
git clone https://github.com/arcticicestudio/nord-gnome-terminal
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/scripts
bash nord-gnome-terminal/src/nord.sh
rm nord-gnome-terminal
cd dotfiles && sh setup.sh
cd ../scripts && sh setup.sh

# REMOVE
apt purge --auto-remove thunderbird hexchat-common libreoffice-common gnome-calendar gnome-calculator onboard-common rhythmbox-data xplayer-common transmission-common pix-data pix-data simple-scan vim-common ed nano flatpak gucharmap gnome-disk-utility xreader-common redshift xviewer gnome-font-viewer seahorse xed-common tomboy baobab gnome-logs gnome-power-manager gimp-data mono-runtime-common gnome-orca timeshift
rm -fr Documents Music Pictures Public Templates Videos .themes .icons .bash_logout

# UPDATE
apt update && apt upgrade
apt purge --auto-remove "$(deborphan)"

# CONFIGURATI0N
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
sudo bash -c "echo 'vm.swappiness = 0' >> /etc/sysctl.conf"
