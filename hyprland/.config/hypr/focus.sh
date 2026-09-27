#!/usr/bin/env bash

set -u

COMMAND="${1:-}"
PATTERN="${2:-}"

if [ -z "$COMMAND" ] || [ -z "$PATTERN" ]; then
    printf '%s\n' "Usage: $0 COMMAND CLASS_REGEX" >&2
    exit 2
fi

# Quote a shell string as a Lua single-quoted string.
lua_quote() {
    local s="$1"
    s=${s//\\/\\\\}
    s=${s//\'/\\\'}
    s=${s//$'\n'/\\n}
    printf "'%s'" "$s"
}

command_lua=$(lua_quote "$COMMAND")
pattern_lua=$(lua_quote "$PATTERN")

# Hyprland 0.55+ Lua API: query a native Window object directly. This avoids class/address
# parsing from `hyprctl clients` and focuses windows even on another workspace.
code="local p=${pattern_lua}; local c=${command_lua}; local w=hl.get_window('class:' .. p); if w == nil then w=hl.get_window('initialclass:' .. p) end; if w ~= nil then hl.dispatch(hl.dsp.focus({ window = w })) else hl.exec_cmd(c) end"

exec hyprctl eval "$code"