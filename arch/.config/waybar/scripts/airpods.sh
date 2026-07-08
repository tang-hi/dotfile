#!/bin/bash
# AirPods battery for waybar. Primary source: librepods' StatusNotifierItem
# tooltip over D-Bus (accurate, per-bud). librepods draws its own tray pixmap
# (unstylable), so the bar skips the tray and renders the number itself.
# Falls back to BlueZ (coarse, 10% steps) when librepods is not running.
# Usage: airpods.sh [activate]
#   (no arg)  print waybar JSON {text, tooltip, class}; empty text when absent
#   activate  open the librepods window (same as clicking its tray icon)

# Waybar removed its tray, so no StatusNotifierWatcher registry exists;
# probe librepods' bus connections for the SNI object directly.
find_librepods() {
    local addr
    while read -r addr; do
        if busctl --user get-property "$addr" /StatusNotifierItem \
            org.kde.StatusNotifierItem Id 2>/dev/null | grep -q '"librepods"'; then
            printf '%s\n' "$addr"
            return 0
        fi
    done < <(busctl --user list --no-pager 2>/dev/null |
        awk '$1 ~ /^:/ && $3 == "librepods" {print $1}')
    return 1
}

emit() { printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$1" "$2" "$3"; }

low_class() { (($1 <= 20)) && echo low || echo connected; }

ADDR=$(find_librepods)

if [[ $1 == activate ]]; then
    [[ -n $ADDR ]] && exec busctl --user call "$ADDR" /StatusNotifierItem \
        org.kde.StatusNotifierItem Activate ii 0 0
    exit 0
fi

if [[ -n $ADDR ]]; then
    tooltip=$(busctl --user get-property "$ADDR" /StatusNotifierItem \
        org.kde.StatusNotifierItem ToolTip 2>/dev/null)
    left=$(grep -oP 'Left: \K[0-9]+' <<<"$tooltip")
    right=$(grep -oP 'Right: \K[0-9]+' <<<"$tooltip")
    case_=$(grep -oP 'Case: \K[0-9]+' <<<"$tooltip")

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
