#!/bin/sh

# Determine the focused output so the launcher can use monitor-specific sizing.
case "${XDG_CURRENT_DESKTOP:-}" in
    mango)
        FOCUS=$(mmsg get all-monitors 2>/dev/null \
            | jq -r '.monitors[] | select(.active) | .name' 2>/dev/null \
            | head -n 1)
        ;;
    niri)
        FOCUS=$(niri msg --json focused-output 2>/dev/null \
            | jq -r '.name // empty' 2>/dev/null)
        ;;
    *)
        FOCUS=""
        ;;
esac

if [ "$FOCUS" = "HDMI-A-1" ]; then
    # Specific size for your 24" Dell Monitor
    # Adjust width and font size to your liking
    exec fuzzel --font="Iosevka Nerd Font:style=semibold:size=18" --line-height=35
else
    # Default size for your laptop screen (eDP-1)
    exec fuzzel
fi
