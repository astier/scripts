#!/usr/bin/env bash

# Opens a url-desktop-file in the browser

grep URL= < "$1"| cut -d'=' -f2 | xargs xdg-open
