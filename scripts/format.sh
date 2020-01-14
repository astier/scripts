#!/usr/bin/env sh

[ ! -f "$1" ] && echo File "$1" does not exist. && exit

# TRIM (http://sed.sourceforge.net/sed1line.txt)
# trailing whitespace
sed -i 's/[ \t]*$//' "$1"
# leading blank lines
# sed -i '/./,$!d' "$1"
# trailing blank lines
sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$1"

case $1 in
    *.py)
        isort "$1"
        black "$1"
        ;;
    *.sh) shfmt -w -ci -sr -p -s -i 4 "$1" ;;
    *) echo Extension not recognized. ;;
esac
