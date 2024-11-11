#!/bin/bash

# Get default source (microphone)
DEFAULT_SOURCE=$(pactl get-default-source)

# Toggle mute state
pactl set-source-mute "@DEFAULT_SOURCE@" toggle

# Get new state
IS_MUTED=$(pactl get-source-mute "@DEFAULT_SOURCE@" | grep -c "Mute: yes")

# Optional: Get mic LED status from ThinkPad
MICMUTE_LED="/sys/class/leds/platform::micmute/brightness"

# Update LED if available
if [ -f "$MICMUTE_LED" ]; then
    if [ "$IS_MUTED" -eq 1 ]; then
        echo 1 | sudo tee "$MICMUTE_LED" > /dev/null
    else
        echo 0 | sudo tee "$MICMUTE_LED" > /dev/null
    fi
fi
