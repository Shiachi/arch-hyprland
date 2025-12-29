#!/bin/bash

killall -q waybar

while pgrep -x waybar >/dev/null; do sleep 1; done

waybar -c "$HOME/.config/waybar/settings/config_primary.jsonc" \
       -s "$HOME/.config/waybar/themes/style_primary.css" &

waybar -c "$HOME/.config/waybar/settings/config_secondary.jsonc" \
       -s "$HOME/.config/waybar/themes/style_secondary.css" &

echo "Waybars launched..."