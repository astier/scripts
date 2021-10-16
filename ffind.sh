#!/usr/bin/env sh

export LC_ALL="C"

find -L . \
    ! -name . \
    ! -name .ccls-cache \
    ! -name .git \
    ! -name .idea \
    ! -name .vscode \
    ! -name __pycache__ \
    ! -name tags \
    ! -path "*/.ccls-cache/*" \
    ! -path "*/.git/*" \
    ! -path "*/.idea/*" \
    ! -path "*/.vscode/*" \
    ! -path "*/__pycache__/*" \
    "$@" \
| cut -c3- | sort
