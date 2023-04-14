#!/usr/bin/env sh

# sudo passwd -l root

[ "$(id -u)" != 0 ] && echo Needs to be run as root. && exit

DATE=/root/lock_date
PERMS=/etc/sudoers.d/lock

[ ! -f "$DATE" ] && touch "$DATE"

if [ ! "$(date -f "$DATE")" ] || [ "$(date -f "$DATE" +%s)" -le "$(date +%s)" ]; then
    [ -f "$PERMS" ] && rm "$PERMS"
    date "+%Y-%m-%d %H:%M:%S" > "$DATE"
    echo unlocked
else
    if [ ! -f "$PERMS" ]; then
        echo "%wheel ALL=(ALL:ALL) !ALL" > "$PERMS"
        echo "%wheel ALL=NOPASSWD:SETENV: /usr/local/bin/lock" >> "$PERMS"
    fi
    echo locked
    date "+%Y-%m-%d %H:%M:%S"
    cat "$DATE"
fi
