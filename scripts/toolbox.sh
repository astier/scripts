#!/usr/bin/env sh

$(grep Exec ~/.local/share/applications/jetbrains-toolbox.desktop | cut -d= -f2 | cut -d" " -f1)
