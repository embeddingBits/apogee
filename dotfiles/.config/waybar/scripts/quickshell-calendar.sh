#!/usr/bin/env bash
# Toggle the standalone Quickshell calendar popup.

config="$HOME/.config/quickshell/calendar.qml"

# If it is already open, close it. Otherwise start a new popup instance.
if qs ipc -p "$config" call calendar close >/dev/null 2>&1; then
    exit 0
fi

# Open on the output that currently has focus.
QS_CALENDAR_SCREEN="$(niri msg --json focused-output 2>/dev/null | jq -r '.name // empty')"
export QS_CALENDAR_SCREEN

exec qs -n -d -p "$config" >/dev/null 2>&1
