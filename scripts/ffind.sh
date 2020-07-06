#!/usr/bin/env sh

find . "$@" ! -path */.git/* ! -name .git ! -path */.idea/* ! -path */__pycache__/* ! -iname *.png ! -name *.toc ! -name *.fdb_latexmk ! -name *.out ! -name *.log ! -name *.fls ! -name *.gz ! -name *.tox ! -name *.nav ! -name *.snm ! -name *.aux ! -name tags ! -name . | cut -c3-
