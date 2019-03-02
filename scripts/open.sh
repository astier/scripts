#!/usr/bin/env bash

# Opens files with different programs based on theit mime-types

[[ "$1" == "" ]] && sxiv -bt . && exit
mime=$(file -bL --mime-type "$1")

prefix=$(echo "$mime" | cut -d"/" -f1)
case "$prefix" in
	"text")
		# Check if it is a url-desktop-file
		if [[ "$1" =~ \.desktop$ ]]; then
			url=$(grep URL= < "$1")
			[[ "$url" ]] && echo "$url" | cut -d"=" -f2 | xargs "$BROWSER" && exit
		fi
		nvim "$1" && exit ;;
	"image") sxiv -b "$1" && exit ;;
esac

suffix=$(echo "$mime" | cut -d"/" -f2)
case "$suffix" in
	"pdf") zathura "$1" && exit
esac

[[ -d "$1" ]] && nautilus "$1" && exit
nvim "$1" && exit
