#!/usr/bin/env bash

# sxiv-wrapper as a workaround for sxivs' disability to open an image
# and beeing able to navigate to other images in the same CWD

if [[ "$1" == "" ]]; then
	sxiv
elif [[ -d "$1" ]]; then
	sxiv -bt "$1"
else
	img_path=$(realpath "$1")
	img_dir=$(dirname "$img_path")
	img_name=$(basename "$1")
	img_no=$(ls "$img_dir" | grep -n "$img_name" | cut -d":" -f1)
	sxiv -bn "$img_no" "$img_dir"
fi
