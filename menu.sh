#!/usr/bin/env sh

# 'cd' fixes: sh: 0: getcwd() failed: No such file or directory
# Reproduce with:
# st -n popup -ig 32x8+400+400 sh -c "nvim >/dev/null 2>&1"
cd /tmp
exec st -n popup -ig 32x8+400+400 sh -c "fzf $* < /proc/$$/fd/0 > /proc/$$/fd/1"
