#!/usr/bin/env sh

find -L . "$@" \
    ! -name *.aux \
    ! -name *.fdb_latexmk \
    ! -name *.fls \
    ! -name *.gz \
    ! -name *.log \
    ! -name *.nav \
    ! -name *.out \
    ! -name *.png \
    ! -name *.snm \
    ! -name *.toc \
    ! -name *.tox \
    ! -name . \
    ! -name .ccls-cache \
    ! -name .git \
    ! -name .idea \
    ! -name .vscode \
    ! -name tags \
    ! -path */.ccls-cache/* \
    ! -path */.git/* \
    ! -path */.idea/* \
    ! -path */.vscode/* \
    ! -path */__pycache__/* \
| cut -c3-
