#!/bin/bash

# Toggle microphone
pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Get mute status
IS_MUTED=$(pactl get-source-mute @DEFAULT_SOURCE@ | grep -c "Mute: yes")

# Update LED
if [ "$IS_MUTED" -eq 1 ]; then
    sudo /usr/local/bin/toggle-mic-led 1
    notify-send "Microphone Muted" -t 1000 -u low
else
    sudo /usr/local/bin/toggle-mic-led 0
    notify-send "Microphone Active" -t 1000 -u low
fi
