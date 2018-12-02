#!/bin/bash

###
# Script to generate scripts.
###

SCRIPT_NAME=$1
SCRIPT=~/Projects/scripts/scripts/$SCRIPT_NAME.sh

if [ -f $SCRIPT ]; then
    echo "ERROR: Script $SCRIPT already exists."
    exit 1
fi

# TODO check if script-name is a system-command

echo "#!/bin/bash" > $SCRIPT
echo -e "\n###\n#\n###" >> $SCRIPT
chmod u+x $SCRIPT
ln -s $SCRIPT ~/bin/$SCRIPT_NAME
$EDITOR $SCRIPT
