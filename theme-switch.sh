#!/bin/bash
# ================================================
# WAYTILES — Theme Switcher
# ================================================
# Usage:
#   bash scripts/theme-switch.sh dragon
#   bash scripts/theme-switch.sh catppuccin
#   bash scripts/theme-switch.sh gruvbox
#   bash scripts/theme-switch.sh        (list all)
# ================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
THEMES_DIR="$REPO_DIR/themes"
KITTY_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty.conf"

THEME="$1"

if [ -z "$THEME" ]; then
  echo "Available themes:"
  for f in "$THEMES_DIR"/*.conf; do
    echo "  $(basename "$f" .conf)"
  done
  echo ""
  echo "Usage: bash scripts/theme-switch.sh <theme-name>"
  exit 0
fi

if [ ! -f "$THEMES_DIR/$THEME.conf" ]; then
  echo "Error: theme '$THEME' not found."
  echo "Run without arguments to list available themes."
  exit 1
fi

if [ ! -f "$KITTY_CONF" ]; then
  echo "Error: kitty.conf not found at $KITTY_CONF"
  exit 1
fi

# Swap the include line in kitty.conf
sed -i "s|^include .*/themes/.*\.conf|include $THEMES_DIR/$THEME.conf|" "$KITTY_CONF"

# Hot-reload Kitty without closing windows
if pgrep -x kitty > /dev/null; then
  kill -SIGUSR1 $(pgrep -x kitty)
  echo "Theme switched to: $THEME (Kitty hot-reloaded)"
else
  echo "Theme switched to: $THEME (open Kitty to apply)"
fi
