#!/usr/bin/env bash

set -u

ID="${1:-}"
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/hypr-waybar-active-workspace"
ACTIVE=""

if [ -r "$STATE_FILE" ]; then
    IFS= read -r ACTIVE < "$STATE_FILE" || true
fi

if [ "$ACTIVE" = "$ID" ]; then
    printf '{"text":"%s","class":"active","tooltip":"Workspace %s"}\n' "$ID" "$ID"
else
    printf '{"text":"%s","class":"inactive","tooltip":"Workspace %s"}\n' "$ID" "$ID"
fi