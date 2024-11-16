#!/bin/bash

BRIGHTNESS_FILE="/tmp/current_brightness"

# Get current brightness
get_brightness() {
    xrandr --verbose | grep -m 1 "Brightness" | cut -f2 -d " "
}

# Increase/decrease brightness
change_brightness() {
    current=$(get_brightness)
    new=$(echo "$current $1" | awk '{print $1 + $2}')
    
    # Ensure brightness stays between 0.1 and 1.0
    if (( $(echo "$new < 0.1" | bc -l) )); then
        new=0.1
    elif (( $(echo "$new > 1.0" | bc -l) )); then
        new=1.0
    fi
    
    xrandr --output eDP-1 --brightness $new
}

# Handle argument
case "$1" in
    "up")
        change_brightness 0.1
        ;;
    "down")
        change_brightness -0.1
        ;;
esac
