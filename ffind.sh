#!/usr/bin/env sh

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
