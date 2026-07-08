#!/bin/bash
# AirPods battery for waybar. Primary source: librepods' StatusNotifierItem
# tooltip over D-Bus (accurate, per-bud). librepods draws its own tray pixmap
# (unstylable), so the bar skips the tray and renders the glyph itself.
# Falls back to BlueZ audio devices (coarse, 10% steps) when librepods has
# no data. Usage: airpods.sh [activate]
#   (no arg)  print waybar JSON {text, tooltip, class}; empty text when absent
#   activate  open the librepods window (same as clicking its tray icon)

# All bus connections owned by librepods processes, newest first. Duplicate
# or restarted instances leave stale SNI objects with empty tooltips behind,
# so callers must scan until they find one that actually carries battery data.
librepods_addrs() {
    busctl --user list --no-pager 2>/dev/null |
        awk '$1 ~ /^:/ && $3 == "librepods" {print $1}' |
        sort -t. -k2,2nr
}

sni_tooltip() {
    busctl --user get-property "$1" /StatusNotifierItem \
        org.kde.StatusNotifierItem ToolTip 2>/dev/null
}

emit() { printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$1" "$2" "$3"; }

low_class() { (($1 <= 20)) && echo low || echo connected; }

# Prefer the connection with live battery data; remember any responsive one
LIVE_ADDR="" ANY_ADDR="" LIVE_TOOLTIP=""
for addr in $(librepods_addrs); do
    tt=$(sni_tooltip "$addr") || continue
    [[ -n $tt ]] && ANY_ADDR=${ANY_ADDR:-$addr}
    if [[ $tt == *"Left:"* || $tt == *"Right:"* ]]; then
        LIVE_ADDR=$addr
        LIVE_TOOLTIP=$tt
        break
    fi
done

if [[ $1 == activate ]]; then
    addr=${LIVE_ADDR:-$ANY_ADDR}
    [[ -n $addr ]] && exec busctl --user call "$addr" /StatusNotifierItem \
        org.kde.StatusNotifierItem Activate ii 0 0
    exit 0
fi

if [[ -n $LIVE_TOOLTIP ]]; then
    left=$(grep -oP 'Left: \K[0-9]+' <<<"$LIVE_TOOLTIP")
    right=$(grep -oP 'Right: \K[0-9]+' <<<"$LIVE_TOOLTIP")
    case_=$(grep -oP 'Case: \K[0-9]+' <<<"$LIVE_TOOLTIP")

    # Lowest charged bud is the number that matters; 0 means absent/no reading
    min=""
    for v in $left $right; do
        ((v > 0 && (${min:-101} > v))) && min=$v
    done
    if [[ -n $min ]]; then
        tip="Left ${left:-0}%  ·  Right ${right:-0}%"
        ((${case_:-0} > 0)) && tip+="  ·  Case ${case_}%"
        emit "$min" "$tip" "$(low_class "$min")"
        exit 0
    fi
fi

# BlueZ fallback: first connected AUDIO device that reports a battery
# (Icon: audio-*), so a keyboard's battery never poses as earbuds
info=$(bluetoothctl devices Connected 2>/dev/null | while read -r _ mac name; do
    dev=$(bluetoothctl info "$mac" 2>/dev/null)
    grep -q 'Icon: audio' <<<"$dev" || continue
    batt=$(grep -oP 'Battery Percentage:.*\(\K[0-9]+' <<<"$dev")
    [[ -n $batt ]] && { printf '%s\t%s\n' "$batt" "$name"; break; }
done)
if [[ -n $info ]]; then
    batt=${info%%$'\t'*}
    name=${info#*$'\t'}
    emit "$batt" "${name} ${batt}%" "$(low_class "$batt")"
else
    emit "" "" ""
fi
