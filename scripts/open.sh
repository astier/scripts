#!/usr/bin/env bash

# Opens files with different programs based on theit mime-types

[[ "$1" == "" ]] && sxrap . && exit
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
	"image") sxrap "$1" && exit ;;
esac

suffix=$(echo "$mime" | cut -d"/" -f2)
case "$suffix" in
	"pdf") zathura "$1" && exit
esac

if [ -d "$1" ]; then
	nautilus "$1"
else
	nvim "$1"
fi
