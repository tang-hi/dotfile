#!/usr/bin/env bash

# Spotify module for waybar using playerctl
# Dependencies: playerctl, spotify

MAX_LENGTH=40

get_status() {
    playerctl -p spotify status 2>/dev/null
}

get_metadata() {
    local title=$(playerctl -p spotify metadata title 2>/dev/null)
    local artist=$(playerctl -p spotify metadata artist 2>/dev/null)

    if [[ -z "$title" ]]; then
        echo ""
        return
    fi

    local output="$title - $artist"

    # Truncate if too long
    if [[ ${#output} -gt $MAX_LENGTH ]]; then
        output="${output:0:$((MAX_LENGTH-1))}..."
    fi

    echo "$output"
}

main() {
    local status=$(get_status)
    local metadata=$(get_metadata)
    local icon=""
    local class=""

    case "$status" in
        "Playing")
            icon="󰓇"
            class="playing"
            ;;
        "Paused")
            icon="󰏤"
            class="paused"
            ;;
        *)
            # Spotify not running
            echo '{"text": "", "class": "stopped"}'
            exit 0
            ;;
    esac

    if [[ -n "$metadata" ]]; then
        echo "{\"text\": \"$icon $metadata\", \"class\": \"$class\", \"tooltip\": \"$(playerctl -p spotify metadata title) - $(playerctl -p spotify metadata artist)\n$(playerctl -p spotify metadata album)\"}"
    else
        echo '{"text": "", "class": "stopped"}'
    fi
}

main
