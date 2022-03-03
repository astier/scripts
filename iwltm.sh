#!/usr/bin/env sh

# iwltm - I would like t-o/alk/o/he/mux-manager.

DIR=/tmp/iwltm
[ ! -d "$DIR" ] && mkdir -p "$DIR"

FILE="$DIR/pane_id"
[ ! -f "$FILE" ] && echo " " > "$FILE"

pane_id="$(cat "$FILE")"

send() {
    # Check if pane exists. If not create new pane.
    if ! tmux has-session -t "$pane_id" > /dev/null 2>&1; then
        pane_id="$(tmux new-window -ac "#{pane_current_path}" -PF "#{pane_id}")"
        echo "$pane_id" > "$FILE"
         # Give shell time to load so send-keys doesnt print keys twice
        sleep 0.1
    fi
    tmux send-keys -t "$pane_id" "$*" ENTER
    # Switch to pane-window if pane-window is not focused
    WINDOW_ID_CURRENT="$(tmux display-message -p "#{window_id}")"
    WINDOW_ID_PANE_ID="$(tmux display-message -pt "$pane_id" "#{window_id}")"
    if [ "$WINDOW_ID_CURRENT" != "$WINDOW_ID_PANE_ID" ]; then
        tmux select-window -t "$pane_id"
    fi
}

[ $# = 0 ] && echo "[--get] [--mark] [--send keys]" && exit

flag="$1"
shift

case "$flag" in
    --get)  echo "$pane_id" ;;
    --mark) [ -n "$TMUX_PANE" ] && echo "$TMUX_PANE" > "$FILE" ;;
    --send) send "$@" ;;
esac
