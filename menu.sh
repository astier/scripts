#!/usr/bin/env sh

st -n menu -ig 32x8+400+400 sh -c "fzf $* < /proc/$$/fd/0 > /proc/$$/fd/1"
