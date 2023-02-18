#!/usr/bin/env sh

# Sort dotfiles first
# https://wiki.archlinux.org/title/locale#LC_COLLATE:_collation
export LC_COLLATE=C

exec find -L . \
    ! -name . \
    ! -name .ccls-cache \
    ! -name .git \
    ! -name .idea \
    ! -name __pycache__ \
    ! -path "*/.ccls-cache/*" \
    ! -path "*/.git/*" \
    ! -path "*/.idea/*" \
    ! -path "*/__pycache__/*" \
    "$@" \
| cut -c3- | sort
