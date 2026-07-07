#!/usr/bin/env bash
# (Re)start the washi desktop widgets. Safe to run repeatedly.

if ! eww ping >/dev/null 2>&1; then
    eww daemon
    sleep 0.5
else
    eww reload
fi

# dashboard1 fails quietly when the second monitor is absent
eww open dashboard0 2>/dev/null
eww open dashboard1 2>/dev/null

exit 0
