#!/usr/bin/env bash

# config.jsonc: topbar reacts to SIGUSR1=toggle, sidebar ignores SIGUSR1.
if pgrep -x waybar >/dev/null 2>&1; then
    exec pkill -SIGUSR1 -x waybar
fi

# Fresh Waybar starts with both bars visible (start_hidden=false).
waybar >/dev/null 2>&1 &