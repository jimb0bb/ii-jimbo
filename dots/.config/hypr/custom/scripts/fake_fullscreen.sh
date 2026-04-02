#!/usr/bin/env bash
set -euo pipefail

MONITOR="DP-1"
STATE_FILE="$HOME/.cache/hdr_state.txt"

# Read previous state (default to off)
if [[ -f "$STATE_FILE" ]]; then
    HDR_STATE=$(<"$STATE_FILE")
else
    HDR_STATE="off"
fi

if [[ "$HDR_STATE" == "on" ]]; then
    echo "HDR is currently ON. Disabling..."
    hyprctl reload
    echo "off" > "$STATE_FILE"
else
    echo "HDR is currently OFF. Enabling..."
    hyprctl --batch "keyword animations:enabled 0; keyword decoration:shadow:enabled 0; keyword decoration:blur:enabled 0; keyword general:gaps_in 0; keyword general:gaps_out 0; keyword general:border_size 0; keyword decoration:rounding 0; keyword general:allow_tearing 1; keyword decoration:active_opacity 1.0; keyword decoration:inactive_opacity 1.0"
    hyprctl keyword monitor "DP-1, preffered, 0x0, 1, vrr, 1,cm,hdr"
    echo "on" > "$STATE_FILE"
fi
