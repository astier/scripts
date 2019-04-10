#!/usr/bin/env bash

# Script to generate scripts.

SCRIPT_NAME=$1
SCRIPT_PATH=~/Projects/scripts/scripts/$SCRIPT_NAME.sh

if [ -z "$SCRIPT_NAME" ]; then
	echo "Please specify a script-name." >&2
	exit 1
fi

echo "#!/usr/bin/env bash" > "$SCRIPT_PATH"
chmod u+x "$SCRIPT_PATH"
ln -fs "$SCRIPT_PATH" ~/.local/bin/"$SCRIPT_NAME"
$EDITOR "$SCRIPT_PATH"
