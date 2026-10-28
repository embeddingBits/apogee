#!/usr/bin/env bash
# Print the focused MangoWM client title for the Waybar custom/window module.
# Outputs nothing when no window is focused, so the module collapses.

title=$(mmsg get focusing-client 2>/dev/null | jq -r '.title // empty' 2>/dev/null)
[[ -z "$title" ]] && exit 0

printf '󰖲  %s\n' "${title:0:32}"
