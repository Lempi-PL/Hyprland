#!/usr/bin/env bash

# config.jsonc: sidebar reacts to SIGUSR2=toggle, topbar ignores SIGUSR2.
if pgrep -x waybar >/dev/null 2>&1; then
    exec pkill -SIGUSR2 -x waybar
fi

# Fresh Waybar starts with both bars visible (start_hidden=false).
waybar >/dev/null 2>&1 &