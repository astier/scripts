#!/usr/bin/env sh

# Return if an instance of memlog is already running
if [ "$(pgrep -af memlog | grep "bin/memlog" | grep -cv grep)" -gt 2 ]; then
    echo AN INSTANCE IS ALREADY RUNNING && return
fi

# Create log-file if it doesn't exist
logs="$XDG_DATA_HOME/memlog"
if [ ! -f "$logs" ]; then
    echo "      date     time $(free -m | grep total | sed -E 's/^    (.*)/\1/g')" > "$logs"
fi

# Write every n seconds the current memory-usage to the log-file
while true; do
    echo "$(date '+%Y-%m-%d %H:%M:%S') $(free -m | grep Mem: | sed 's/Mem://g')" >> "$logs"
    sleep 1
done

