# Washi — desktop design system

A light, quiet, restrained desktop theme: the whole desktop is a sheet of warm
paper, and the UI is ink and soft pigment on it. Every color comes from the
traditional Japanese palette; the aesthetic is carried by color, spacing and
type — all UI text stays in English.

## Design principles

- **Ma (negative space)** — larger window gaps (6/14), 18–20px card padding,
  modules separated by spacing alone, no divider lines.
- **Kanso (simplicity)** — the bar keeps only the essentials (workspaces /
  now playing / title / volume / network / bluetooth / clock / power).
  CPU, memory, weather and the date live in the desktop cards; no piece of
  information is shown twice.
- **One visual language** — radii 10–14 (windows 12, cards 12, large overlays
  14), 1px hairline borders, low-opacity paper surfaces over background blur,
  soft wide shadows (paper resting just above the desk).
- **Calm motion** — ease-out curves, 300–400ms, no overshoot, no looping
  border animation.
- **A single stroke of red** — the only saturated accent on the desktop is
  one vermillion stroke in the clock card (plus critical states).

## Palette (WCAG contrast checked against the paper surface)

| Token      | Hex       | Traditional name | Role                                | Contrast |
|------------|-----------|------------------|-------------------------------------|----------|
| `paper`    | `#F5F1E6` | kinari           | base paper                          | —        |
| `surface`  | `#FAF7EF` | shironeri        | cards / bar / overlays (85–96%)     | —        |
| `surface2` | `#F1EBDD` | suna             | recessed / troughs / hover          | —        |
| `hairline` | `#DBD3C1` | —                | 1px borders                         | —        |
| `ink`      | `#3E3A32` | sumi             | primary text                        | 10.6:1   |
| `ink2`     | `#6E695C` | nibi             | secondary text / icons              | 5.1:1    |
| `ink3`     | `#A29B89` | usuzumi          | disabled / placeholder / inactive   | decor    |
| `ai`       | `#56708C` | ainezu           | primary accent: selection / active  | 4.8:1    |
| `matsuba`  | `#66774F` | matsuba          | success / terminal green            | 4.5:1    |
| `karashi`  | `#97783C` | karashi          | warning / terminal yellow           | 3.9:1    |
| `shu`      | `#A85049` | sabi-shu         | danger / critical / the one red     | 5.0:1    |
| `seiji`    | `#5E8A80` | seiji            | decorative cyan / disk meter        | 3.6:1    |
| `fuji`     | `#7D7397` | fujinezu         | decorative violet / RAM meter       | 4.1:1    |

## Type scale

- **UI text**: Inter (`tnum` tabular figures so clocks and percentages don't jitter)
- **Large clock**: Inter Light 44px (desktop card) / 96px (lock screen)
- **Icons**: Maple Mono NF CN (nerd glyphs, as Inter's fallback)
- **Terminal / mono**: Maple Mono NF CN (unchanged)
- **Input method candidates**: LXGW WenKai 13 (switch to a sans in
  `fcitx5/conf/classicui.conf` → `Font` if preferred)

## Components

| Component | Files                                          | Notes |
|-----------|------------------------------------------------|-------|
| Waybar    | `waybar/config`, `waybar/style.css`            | Two paper islands — left (workspaces + now playing), right (status + clock) — with a free-floating centered title; CPU/MEM/weather modules removed |
| eww       | `eww/eww.yuck`, `eww/eww.scss`, `eww/scripts/` | Clock card (one vermillion stroke), calendar card, thin-line meters (CPU/RAM/Disk), weather card; `start.sh` restored, `weather.sh` added |
| Hyprland  | `hypr/hyprland.conf`                           | gaps 6/14, rounding 12, paper shadows, ainezu active border, calm animations, blur layer rules for waybar/eww/dunst |
| Ghostty   | `ghostty/config`                               | washi 16-color palette, opacity 0.94 (reload open windows with Ctrl+Shift+F5) |
| kitty     | `kitty/kitty.conf`                             | same palette, incl. tabs/borders/marks |
| Rofi      | `rofi/colors/washi.rasi` + spotlight/powermenu | launcher and power menu on paper surfaces, Inter |
| Dunst     | `dunst/dunstrc`                                | paper + 1px hairline frame, vermillion critical frame, Inter |
| fcitx5    | `.local/share/fcitx5/themes/washi/`            | rounded paper candidate panel, ainezu highlight |
| Hyprlock  | `hypr/hyprlock.conf`                           | frosted background, ink clock, paper input field (background image unchanged) |
| btop      | `btop/themes/washi.theme`                      | full gradient set |

**Untouched**: wallpaper, nvim (rose pine), GTK/Qt themes (SpringCity/Tela),
cursor theme.

## Weather

`eww/scripts/weather.sh` fetches from **wttr.in** once per poll cycle (cached
in `$XDG_RUNTIME_DIR`). The city is pinned via `LOCATION="Hangzhou"` at the
top of the script — IP-based lookup is deliberately avoided because behind a
proxy/VPN wttr.in geolocates the exit node (a faraway datacenter), not you.

## Reload / rollback

```bash
# reload
pkill waybar && waybar &          # bar
~/.config/eww/scripts/start.sh    # desktop cards
hyprctl reload                    # window manager
pkill dunst && dunst &            # notifications
fcitx5-remote -r                  # input method

# rollback (inside the repo)
git -C ~/repo/dotfile checkout -- arch/
```
