#!/bin/bash

# Script to automatically adjust monitor brightness based on time.
# Uses ddcutil to control brightness via DDC/CI.

# Function to set brightness for all detected monitors
set_brightness() {
    local brightness="$1" # Brightness level (0-100)
    local monitors
    monitors=$(ddcutil detect | grep -Po "Display \d" | wc -l)

    if [[ -z "$monitors" || "$monitors" -eq 0 ]]; then
        # echo "Error: No monitors detected by ddcutil."
        exit 1
    fi

    for i in $(seq 1 "$monitors"); do
        # echo "Setting brightness on Display $i to $brightness"
        ddcutil --display "$i" setvcp 10 "$brightness" >/dev/null 2>&1
        if [[ $? -ne 0 ]]; then
            echo "Error: Failed to set brightness on Display $i."
        fi
    done
}

current_hour=$(date +%H) # Get the current hour (24-hour format)

case "$current_hour" in
07 | 08 | 09 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18) # 7 AM - 6 PM (inclusive)
    set_brightness 100
    ;;
19 | 20 | 21) # 7 PM - 9 PM (inclusive)
    set_brightness 50
    ;;
22 | 23 | 00 | 01 | 02 | 03 | 04 | 05 | 06) # 10 PM - 6 AM (inclusive)
    set_brightness 0
    ;;
*)
    exit 0
    ;;
esac

exit 0
