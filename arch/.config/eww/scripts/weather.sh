#!/usr/bin/env bash
# Weather for the washi dashboard (data from wttr.in).
#
# With no location, wttr.in guesses the city from the exit IP. Behind a
# proxy/VPN that IP is a datacenter far away, so pin your city here
# (URL syntax: "Taipei", "New+York", an airport code like "TPE", ...):
LOCATION="Hangzhou"

CACHE="${XDG_RUNTIME_DIR:-/tmp}/washi-weather"
MAX_AGE=1500 # seconds; slightly shorter than the eww poll interval

fresh() {
    [[ -s $CACHE ]] || return 1
    local age=$(($(date +%s) - $(stat -c %Y "$CACHE")))
    ((age < MAX_AGE))
}

if ! fresh; then
    data=$(curl -sf --max-time 10 "wttr.in/${LOCATION}?format=%c|%t|%C" 2>/dev/null)
    [[ -n $data ]] && printf '%s' "$data" >"$CACHE"
fi

IFS='|' read -r icon temp desc <"$CACHE" 2>/dev/null

case "$1" in
    icon) printf '%s\n' "${icon:+${icon// /}}" ;;
    temp) printf '%s\n' "${temp:+${temp/+/}}" ;;
    desc) printf '%s\n' "${desc:-N/A}" ;;
    *) printf '%s %s %s\n' "${icon// /}" "${temp/+/}" "$desc" ;;
esac
