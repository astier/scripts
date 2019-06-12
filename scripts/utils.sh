#!/usr/bin/env sh

# # Neovim-Python-IDE
# conda create -n ide isort jedi pylint rope
# conda activate ide
# pip install black python-language-server
# conda deactivate

clean_system() {
	echo "Remove Orphans..."
	pacman -Qttdq | sudo pacman -Rns -
	printf "\nClean Pacman-Cache"
	sudo pacman -Sc
	printf "\nClean Conda-Cache"
	conda clean -a
	printf "\nClean ~/.cache"
	# rm -fr ~/.cache/*
	printf "\nClean Home-Folder manually!\n"
	# TODO /var & other log-files
	# TODO check rmlint (broken symlinks, duplicates, empty files/dirs, etc.)
	# TODO disk-analyzer<Paste>
}

create_err_log() {
	# Detect and store system-errors and -warnings which occured at the last bootup
	LOG_DIR=~/ERROR_LOG
	[ ! -d $LOG_DIR ] && mkdir $LOG_DIR
	journalctl -p3 -xb > $LOG_DIR/journalctl                                # Kernel
	systemctl --all --failed > $LOG_DIR/systemctl                           # Services
	grep -e '(EE)' -e '(WW)' ~/.local/share/xorg/Xorg.0.log > $LOG_DIR/xorg # Xorg
}

case $@ in
	-c) clean_system ;;
	-e) create_err_log ;;
	*)
		echo Invalid arguments. >&2
		exit 1
		;;
esac
