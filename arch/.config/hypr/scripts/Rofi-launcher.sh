#!/bin/bash
## Spotlight-style App Launcher

dir="$HOME/.config/rofi/launchers/type-1"
theme='spotlight'

rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
