#!/usr/bin/env sh
BG="ffb599"
DARK_MODE="true"

# Color candidates (baked by matugen at template time)
DARK_NORMAL="ff591a"
LIGHT_NORMAL="ffffff"
DARK_NORMAL_BOOSTED="ff591a"
LIGHT_NORMAL_BOOSTED="ffffff"

# --- Extract RGB from BG ---
R=$((16#${BG:0:2}))
G=$((16#${BG:2:2}))
B=$((16#${BG:4:2}))

AVG=$(( (R + G + B) / 3 ))

# --- Reduce blue channel of a hex color ---
reduce_blue_dark() {
    C="$1"
    r=$((16#${C:0:2}))
    g=$((16#${C:2:2}))
    b=$((16#${C:4:2}))
    r=$(( r + 60 ))
    b=$(( b - 60 ))
    [ "$b" -lt 0 ] && b=0
    printf '%02x%02x%02x' "$r" "$g" "$b"
}

reduce_blue_light() {
    C="$1"
    r=$((16#${C:0:2}))
    g=$((16#${C:2:2}))
    b=$((16#${C:4:2}))
    r=$(( r + 60 ))
    b=$(( b - 60 ))
    [ "$b" -lt 0 ] && b=0
    printf '%02x%02x%02x' "$r" "$g" "$b"
}

# Computed at runtime from the matugen-baked values
DARK_REDUCED=$(reduce_blue_dark "$DARK_NORMAL")
LIGHT_REDUCED=$(reduce_blue_light "$LIGHT_NORMAL")

# --- Blue dominance check ---
is_blue_dominant() {
    C="$1"
    r=$((16#${C:0:2}))
    g=$((16#${C:2:2}))
    b=$((16#${C:4:2}))
    [ "$b" -gt "$r" ] && [ "$b" -gt "$g" ] && [ $(( b - r )) -gt 10 ] && return 0
}

# --- Brown detection (red > green > blue, warm and muted) ---
is_brown() {
    C="$1"
    r=$((16#${C:0:2}))
    g=$((16#${C:2:2}))
    b=$((16#${C:4:2}))
    [ "$r" -gt "$g" ] && [ "$g" -gt "$b" ] && [ $(( r - b )) -gt 40 ] && [ "$r" -lt 220 ] && return 0
}

# --- Select color ---
if [ "$DARK_MODE" = "true" ]; then
    if is_blue_dominant "$DARK_NORMAL"; then
        COLOR="$DARK_REDUCED"
    elif is_brown "$DARK_NORMAL"; then
        COLOR="$DARK_NORMAL_BOOSTED"
    else
        COLOR="$DARK_NORMAL"
    fi
    exit_code=1
else
    if is_blue_dominant "$LIGHT_NORMAL"; then
        COLOR="$LIGHT_REDUCED"
    elif is_brown "$LIGHT_NORMAL"; then
        COLOR="$LIGHT_NORMAL_BOOSTED"
    else
        COLOR="$LIGHT_NORMAL"
    fi
    exit_code=0
fi

openrgb --color "$COLOR" -m direct -b 100
exit "$exit_code"
