#!/usr/bin/env sh

filename=".git"
directory=$(pwd)

while [ "$directory" != "/" ]; do
    if [ -e "$directory/$filename" ]; then
        echo "$directory"
        break
    fi
    directory=$(dirname "$directory")
done
