#!/usr/bin/env bash
COLORS="$HOME/.config/matugen/colors.json"
if [ ! -f "$COLORS" ]; then
  echo "No colors file found"
  exit 1
fi
PRIMARY=$(jq -r '.primary' "$COLORS" | sed 's/#//')
OUTLINE=$(jq -r '.outline_variant' "$COLORS" | sed 's/#//')

# Apply colors directly via hyprctl keyword
hyprctl eval "hl.config({general={['col.active_border']='rgba(${PRIMARY}33)'}})"
hyprctl eval "hl.config({general={['col.inactive_border']='rgba(${OUTLINE}22)'}})"

# Reload kitty
kill -SIGUSR1 $(pgrep kitty) 2>/dev/null || true

# Reload waybar
pkill waybar && waybar --config ~/.config/waybar/hyprland-config &