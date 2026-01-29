#!/usr/bin/env bash

# Weather module for waybar using wttr.in

get_weather() {
    # Get weather data (auto location based on IP)
    weather=$(curl -sf "wttr.in/?format=%c%t" 2>/dev/null)

    if [[ -z "$weather" ]]; then
        echo '{"text": "N/A", "tooltip": "无法获取天气", "class": "error"}'
        return
    fi

    # Get detailed info for tooltip
    tooltip=$(curl -sf "wttr.in/?format=%l:+%c+%C+%t+%h+%w" 2>/dev/null)

    # Clean up the output (remove + sign from temperature)
    weather=$(echo "$weather" | sed 's/+//')

    echo "{\"text\": \"$weather\", \"tooltip\": \"$tooltip\", \"class\": \"weather\"}"
}

get_weather
