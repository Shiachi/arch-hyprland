#!/bin/bash

monitors=($(hyprctl monitors -j | jq -r 'sort_by(.x) | .[].name'))
PRIMARY_MONITOR=${monitors[0]}
SECONDARY_MONITOR=${monitors[1]}

CURRENT_MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')

if [[ "$CURRENT_MONITOR" == "$PRIMARY_MONITOR" ]]; then
    THEME_TYPE="primary"
elif [[ "$CURRENT_MONITOR" == "$SECONDARY_MONITOR" ]]; then
    THEME_TYPE="secondary"
else
    THEME_TYPE="$CURRENT_MONITOR"
fi

BASE_CONFIG="$HOME/.config/kitty/kitty.conf"
THEME_FILE="$HOME/.config/kitty/colors_${THEME_TYPE}.conf"

if [ -f "$THEME_FILE" ]; then
    kitty -c "$BASE_CONFIG" -c "$THEME_FILE" "$@"
else
    kitty "$@"
fi