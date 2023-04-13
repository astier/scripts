#!/usr/bin/env sh

# sudo passwd -l root

[ "$(id -u)" != 0 ] && echo Needs to be run as root. && exit

PERM_FILE=/etc/sudoers
LOCKED="%wheel ALL=NOPASSWD:SETENV: /usr/local/bin/lock"
UNLOCKED="%wheel ALL=(ALL:ALL) NOPASSWD: ALL"

RC=/root/lockrc
[ ! -f "$RC" ] && date "+%Y-%m-%d %H:%M:00" > "$RC"
date "+%Y-%m-%d %H:%M:%S"
cat "$RC"

if [ ! "$(date -f "$RC")" ] || [ "$(date -f "$RC" +%s)" -le "$(date +%s)" ]; then
    sed -i "s|^$LOCKED$|$UNLOCKED|" "$PERM_FILE"
    echo Unlocked.
else
    sed -i "s|^$UNLOCKED$|$LOCKED|" "$PERM_FILE"
    echo Locked.
fi
