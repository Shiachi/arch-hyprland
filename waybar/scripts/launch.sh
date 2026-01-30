#!/bin/bash

killall -q waybar

while pgrep -x waybar >/dev/null; do sleep 0.1; done
hyprctl reload

monitors=($(hyprctl monitors -j | jq -r 'sort_by(.x) | .[].name'))
export PRIMARY_MONITOR=${monitors[0]}
export SECONDARY_MONITOR=${monitors[1]}

envsubst < "$HOME/.config/waybar/settings/config_primary.template" > "/tmp/waybar_primary.jsonc"

waybar -c "/tmp/waybar_primary.jsonc" \
       -s "$HOME/.config/waybar/themes/style_primary.css" > /dev/null 2>&1 &

if [[ "$SECONDARY_MONITOR" != "None" ]]; then
    envsubst < "$HOME/.config/waybar/settings/config_secondary.template" > "/tmp/waybar_secondary.jsonc"

    waybar -c "/tmp/waybar_secondary.jsonc" \
           -s "$HOME/.config/waybar/themes/style_secondary.css" > /dev/null 2>&1 &
fi