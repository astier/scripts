#!/usr/bin/env bash

# Clean the system.

echo "Remove Orphans..."
sudo pacman -Rns "$(pacman -Qdtq)"

echo -e "\nClean Pacman-Cache..."
sudo pacman -Sc

echo -e "\nClean Conda-Cache"
conda clean -a

echo -e "\nClean Home-Folder manually!"

# TODO check rmlint (broken symlinks, duplicates, empty files/dirs, etc.)
# TODO disk-analyzer
