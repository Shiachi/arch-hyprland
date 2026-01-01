#!/bin/bash

killall -q waybar

while pgrep -x waybar >/dev/null; do sleep 0.1; done
hyprctl reload

waybar -c "$HOME/.config/waybar/settings/config_primary.jsonc" \
       -s "$HOME/.config/waybar/themes/style_primary.css" > /dev/null 2>&1 &

# Launch Secondary Waybar (Silent)
waybar -c "$HOME/.config/waybar/settings/config_secondary.jsonc" \
       -s "$HOME/.config/waybar/themes/style_secondary.css" > /dev/null 2>&1 &