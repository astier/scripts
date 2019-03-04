#!/usr/bin/env bash

# Script to generate scripts.

script_name=$1
script_path=~/Projects/scripts/scripts/$script_name.sh

if [ -f "$script_path" ]; then
	echo "ERROR: Script $script_path already exists."
elif [ "$script_name" == "" ]; then
	echo "Please specify a sctipt-name."
else
	echo "#!/usr/bin/env bash" > "$script_path"
	echo -e "\n#" >> "$script_path"
	chmod u+x "$script_path"
	ln -sf "$script_path" ~/.local/bin/"$script_name"
	$EDITOR "$script_path"
fi
