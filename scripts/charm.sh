#!/usr/bin/env sh

$(grep Exec ~/.local/share/applications/jetbrains-pycharm.desktop | cut -d\" -f2)
