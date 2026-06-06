# waytiles

> High-contrast KDE tiling dotfiles. Dragon theme by default — fully themeable.

<img width="1920" height="1078" alt="image" src="https://github.com/user-attachments/assets/5efa2f2e-3e2c-4647-be06-75754b288daf" />


## Setup

| Component | Details |
|-----------|---------|
| OS | Fedora Linux 44 (KDE Plasma) |
| Terminal | Kitty |
| Font | JetBrainsMono Nerd Font |
| Monitor | btop |
| Fetch | fastfetch |
| Shell prompt | custom bash/zsh |

## Installation

```bash
git clone https://github.com/YourNick/waytiles.git
cd waytiles
bash scripts/install.sh
```

The install script symlinks all configs to the right places. Your existing configs are backed up automatically.

## Switching themes

```bash
bash scripts/theme-switch.sh dragon       # default — high contrast red/black
bash scripts/theme-switch.sh catppuccin   # mocha — soft dark purple
bash scripts/theme-switch.sh gruvbox      # warm earth tones
```

Or edit `kitty/kitty.conf` manually — change the `include` line:

```
include ../themes/dragon.conf
```

Hot-reload with `Ctrl+Shift+F5` in Kitty — no restart needed.

## Custom colors

Open `themes/dragon.conf` and change any hex value. Every other config pulls from this file automatically via `include`.

Key values to change:

| Variable | Default | What it controls |
|----------|---------|-----------------|
| `foreground` | `#ff0000` | Text and accents |
| `background` | `#0a0a0a` | Terminal background |
| `active_border_color` | `#ff0000` | Active tiling border |
| `color1` / `color9` | `#cc0000` / `#ff0000` | Red (normal / bright) |

## Tiling keybinds (Kitty)

| Keybind | Action |
|---------|--------|
| `Ctrl+Alt+V` | Split vertical |
| `Ctrl+Alt+H` | Split horizontal |
| `Ctrl+Alt+R` | Reset / re-tile windows |
| `Ctrl+Shift+F5` | Reload config |

## Troubleshooting

**Windows desync after suspend**
Press `Ctrl+Alt+R` — fires `layout_action resize_to_divide 2` and re-tiles everything.

**Waybar breaks / CSS transform errors**
GTK ignores `transform` on some widgets. Replace with `margin` in `waybar/style.css`, then restart:
```bash
pkill waybar && waybar &
```

**Missing Nerd Font symbols (showing `?` boxes)**
```bash
sudo dnf install jetbrains-mono-fonts
fc-cache -fv
```
Full Kitty restart required (not just reload).

**Hot-reload reference**

| App | Command |
|-----|---------|
| Kitty config | `Ctrl+Shift+F5` |
| Kitty theme only | `kill -SIGUSR1 $(pgrep kitty)` |
| Waybar | `pkill waybar && waybar &` |
| btop | `Shift+R` inside btop |
| KWin tiling | `qdbus org.kde.KWin /KWin reconfigure` |

**Undo a bad git commit**
```bash
git reset --soft HEAD~1   # undo commit, keep file changes
```

## License

MIT — fork it, theme it, make it yours.
