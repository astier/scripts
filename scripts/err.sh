#!/usr/bin/env bash

# Detect and store system-errors and -warnings which occured at the last bootup.

# Create directory for storing the error-files
DIR=~/ERRORS
mkdir $DIR

# Detect and store errors
journalctl -p3 -xb > $DIR/journalctl  # Kernel
systemctl --all --failed > $DIR/systemctl  # Services
cat ~/.local/share/xorg/Xorg.0.log | grep -e '(EE)' -e '(WW)' > $DIR/xorg  # Xorg
