#!/usr/bin/env bash

## Power Menu - Catppuccin Latte Style

dir="$HOME/.config/rofi/powermenu/type-6"
theme='style-1'

uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)

# Options (Nerd Font icons)
lock="󰌾"
suspend="󰤄"
logout="󰍃"
hibernate="󰋊"
reboot="󰜉"
shutdown="󰐥"
yes="󰄬"
no="󰅖"

rofi_cmd() {
	rofi -dmenu \
		-p " $USER@$host" \
		-mesg " Uptime: $uptime" \
		-theme "${dir}/${theme}.rasi"
}

confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px; border-radius: 16px;}' \
		-theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you sure?' \
		-theme "${dir}/${theme}.rasi"
}

confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
}

run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--hibernate' ]]; then
			systemctl hibernate
		elif [[ $1 == '--suspend' ]]; then
			mpc -q pause 2>/dev/null
			systemctl suspend
		elif [[ $1 == '--logout' ]]; then
			hyprctl dispatch exit
		fi
	else
		exit 0
	fi
}

chosen="$(run_rofi)"
case ${chosen} in
    $lock)
		hyprlock
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
    $hibernate)
		run_cmd --hibernate
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $shutdown)
		run_cmd --shutdown
        ;;
esac
