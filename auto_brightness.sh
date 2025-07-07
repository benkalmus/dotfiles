#! /usr/bin/env bash

# Script to automatically adjust monitor brightness based on time.
# Uses ddcutil to control brightness via DDC/CI.
# Optimizations:
#   - Caches display IDs to avoid repeated ddcutil detect calls.
#   - Checks current brightness before setting to avoid unnecessary DDC/CI commands.

# Cache file for display IDs
DISPLAY_CACHE_FILE="/tmp/ddcutil_display_cache.txt"
display_ids=()

# Function to get display IDs, using the cache if available
get_display_ids() {
    if [[ -f "$DISPLAY_CACHE_FILE" ]]; then
        readarray -t display_ids <"$DISPLAY_CACHE_FILE"
        if [[ ${#display_ids[@]} -gt 0 ]]; then
            # echo "Using cached display IDs."
            return 0
        fi
    fi

    # Detect monitors and cache display IDs
    local monitors
    monitors=$(ddcutil detect | grep -Po "Display \d" | awk '{print $2}')

    if [[ -z "$monitors" ]]; then
        echo "Error: No monitors detected by ddcutil."
        return 1 # failure
    fi

    #populate the display ids array
    while IFS= read -r display_id; do
        display_ids+=("$display_id")
    done <<<"$monitors" #pipe the monitors string through a loop.

    #now save it to the file
    printf "%s\n" "${display_ids[@]}" >"$DISPLAY_CACHE_FILE"
}

# Function to set brightness for a specific display ID
set_brightness() {
    local display_id="$1"
    local target_brightness="$2"

    local current_brightness
    current_brightness=$(ddcutil --display "$display_id" getvcp 10 | grep -Po "current value =.*," | grep -Po "\d*")

    if [[ -z "$current_brightness" ]]; then
        echo "Error: Couldn't determine current brightness for Display $display_id. Skipping."
        return 1
    fi

    if [[ "$current_brightness" -eq "$target_brightness" ]]; then
        # echo "Brightness on Display $display_id is already at $target_brightness. Skipping."
        return 0
    fi

    # echo "Setting brightness on Display $display_id from $current_brightness to $target_brightness"
    ddcutil --display "$display_id" setvcp 10 "$target_brightness" >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to set brightness on Display $display_id."
    fi
    return 0
}

#Function to delete cache file when we suspect something changed, like monitor config
clear_cache() {
    if [[ -f "$DISPLAY_CACHE_FILE" ]]; then
        echo "clearing display cache file at $DISPLAY_CACHE_FILE"
        rm "$DISPLAY_CACHE_FILE"
    fi
}

#Every hour we suspect monitor configuration might have changed so we reset the cache
# checks if hour is in the first 5 minutes HH:MM < HH:05.
if ((10#$(date +%M) <= 5)); then
    clear_cache
fi

# Get the current hour (24-hour format)
current_hour="10#$(date +%H)"

# Get display IDs
get_display_ids
if [[ -z "${display_ids[*]}" ]]; then
    echo "Error: Could not retrieve display IDs."
    exit 1
fi

target_brightness=0

# Note, must start with largest value
# telling bash to use base 10 #10 because cucrent hour is printedf with a leading 0
if ((current_hour >= 23)); then
    target_brightness=10
elif ((current_hour >= 21)); then
    target_brightness=50
elif ((current_hour >= 19)); then
    target_brightness=60
elif ((current_hour >= 18)); then
    target_brightness=80
elif ((current_hour >= 6)); then
    target_brightness=100
elif ((current_hour >= 0)); then
    target_brightness=0
fi

# Loop through display IDs and set brightness
for display_id in $display_ids; do
    set_brightness "$display_id" "$target_brightness"
done

# echo "Brightness adjustment process completed."
exit 0
