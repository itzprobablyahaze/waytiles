#!/bin/bash
# ================================================
# WAYTILES — Install Script
# ================================================
# Symlinks configs to the correct locations.
# Backs up existing configs automatically.
# ================================================

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP_DIR="$HOME/.waytiles-backup-$(date +%Y%m%d%H%M%S)"

echo "waytiles installer"
echo "=================="
echo "Repo:   $REPO_DIR"
echo "Config: $CONFIG_DIR"
echo ""

backup_and_link() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    cp -r "$dst" "$BACKUP_DIR/"
    echo "  backed up: $(basename "$dst")"
    rm -rf "$dst"
  elif [ -L "$dst" ]; then
    rm "$dst"
  fi

  ln -s "$src" "$dst"
  echo "  linked:    $dst"
}

echo "Linking configs..."
backup_and_link "$REPO_DIR/kitty/kitty.conf"   "$CONFIG_DIR/kitty/kitty.conf"
backup_and_link "$REPO_DIR/kitty/session.conf" "$CONFIG_DIR/kitty/session.conf"

[ -f "$REPO_DIR/btop/btop.conf" ] \
  && backup_and_link "$REPO_DIR/btop/btop.conf" "$CONFIG_DIR/btop/btop.conf"

[ -f "$REPO_DIR/fastfetch/config.jsonc" ] \
  && backup_and_link "$REPO_DIR/fastfetch/config.jsonc" "$CONFIG_DIR/fastfetch/config.jsonc"

chmod +x "$REPO_DIR/scripts/theme-switch.sh"

echo ""
echo "Done!"
[ -d "$BACKUP_DIR" ] && echo "Old configs backed up to: $BACKUP_DIR"
echo ""
echo "Switch themes with:"
echo "  bash $REPO_DIR/scripts/theme-switch.sh dragon"
echo "  bash $REPO_DIR/scripts/theme-switch.sh catppuccin"
echo "  bash $REPO_DIR/scripts/theme-switch.sh gruvbox"
