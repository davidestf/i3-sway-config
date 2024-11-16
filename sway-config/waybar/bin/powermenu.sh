#!/bin/bash

# Define the options
options=("⭮ Cancel" "⏻ Shutdown" "⭘ Reboot" "⏾ Hibernate" "⏿ Suspend" "⇠ Logout" "🔒 Lock")

if [ -z "$1" ]; then
    # Show wofi menu with all options
    selected=$(printf '%s\n' "${options[@]}" | wofi \
        --dmenu \
        --cache-file /dev/null \
        --prompt "Power Menu" \
        --width 200 \
        --height 300 \
        --style ~/.config/wofi/power.css \
        --hide-scroll \
        --insensitive \
        --define "matching=fuzzy")
else
    selected="$1"
fi

# Convert selection to lowercase and remove icons for case matching
choice=$(echo "$selected" | sed 's/^[^ ]* //')

case "${choice,,}" in
    "cancel")
        exit 0
        ;;
    "shutdown")
        systemctl poweroff
        ;;
    "reboot")
        systemctl reboot
        ;;
    "hibernate")
        systemctl hibernate
        ;;
    "suspend")
        systemctl suspend
        ;;
    "logout")
        swaymsg exit
        ;;
    "lock")
        swaylock -f -i ~/.config/i3/tower-nord.png
        ;;
    *)
        exit 0
        ;;
esac
