#!/usr/bin/env sh

# sudo passwd -l root

# doas.conf: permit persist keepenv :wheel
# doas.conf: permit nopass  keepenv :wheel as root cmd lock

[ "$(id -u)" != 0 ] && echo Needs to be run as root. && exit

DIR=$XDG_CONFIG_HOME/lock/
[ ! -d "$DIR" ] && mkdir "$DIR"

DATE=$DIR/date
[ ! -f "$DATE" ] && date "+%Y-%m-%d %H:%M:00" > "$DATE"

PASS=$DIR/pass
if [ ! -f "$PASS" ]; then
    echo No password set. > "$PASS"
    chmod 600 "$PASS"
    chattr +i "$PASS"
fi

date "+%Y-%m-%d %H:%M:%S"
cat "$DATE"

if [ ! "$(date -f "$DATE")" ] || [ "$(date -f "$DATE" +%s)" -le "$(date +%s)" ]; then
    cat "$PASS"
elif [ "$(date -r "$PASS" +%s)" -lt "$(date -r "$DATE" +%s)" ]; then
    chattr -i "$PASS"
    shuf -i 0000-9999 -n 1 > "$PASS"
    chattr +i "$PASS"
    echo "$(echo "$XDG_CONFIG_HOME" | cut -d/ -f3):$(cat "$PASS")" | chpasswd
    echo New password set.
else
    echo Countdown running.
fi
