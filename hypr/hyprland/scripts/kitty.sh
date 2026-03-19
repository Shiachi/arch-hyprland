#!/bin/bash

# 1. Get the name of the monitor where the active workspace is currently located
MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')

# 2. Define the path to your base config and the monitor-specific theme
BASE_CONFIG="$HOME/.config/kitty/kitty.conf"
THEME_FILE="$HOME/.config/kitty/colors-${MONITOR}.conf"

# 3. Launch Kitty
# If the monitor-specific theme exists, load the base config AND the theme config.
# Kitty reads multiple --config (-c) flags in order, letting the theme overwrite defaults.
if [ -f "$THEME_FILE" ]; then
    kitty -c "$BASE_CONFIG" -c "$THEME_FILE" "$@"
else
    # Fallback to normal Kitty if the monitor theme file is missing
    kitty "$@"
fi