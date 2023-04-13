#!/usr/bin/env sh

# sudo passwd -l root

[ "$(id -u)" != 0 ] && echo Needs to be run as root. && exit

DOAS=/etc/doas.conf
DOAS_LOCKED="permit nopass keepenv :wheel as root cmd /usr/bin/lock"
DOAS_UNLOCKED="permit nopass keepenv :wheel"

RC=/root/lockrc
[ ! -f "$RC" ] && date "+%Y-%m-%d %H:%M:00" > "$RC"
date "+%Y-%m-%d %H:%M:%S"
cat "$RC"

if [ ! "$(date -f "$RC")" ] || [ "$(date -f "$RC" +%s)" -le "$(date +%s)" ]; then
    sed -i "s|^$DOAS_LOCKED$|$DOAS_UNLOCKED|" "$DOAS"
    echo Unlocked.
else
    sed -i "s|^$DOAS_UNLOCKED$|$DOAS_LOCKED|" "$DOAS"
    echo Locked.
fi
