#!/bin/bash

# Kill any existing redshift
#killall -q redshift

# Wait for processes to end
#while pgrep -x redshift >/dev/null; do sleep 1; done

# Start redshift with explicit randr method
#redshift -m randr -l 51.5:-0.12 -t 5700:5000 -r &

# Optional: wait a moment and check if it started
#sleep 1
#if ! pgrep redshift >/dev/null; then
#    echo "Failed to start redshift"
#    exit 1
#fi


# Kill any existing redshift
killall -9 redshift 2>/dev/null

# Wait a moment
sleep 1

# Start redshift with the config
#if [ -f "~/.config/i3/redshift.con" ]; then
#    redshift -c "~/.config/i3/redshift.con" &
#    echo "Redshift started with config file"
#else
    # Fallback to default settings if no config file found
    redshift -m randr -l 51.5:-0.12 -t 5700:5800 &

    echo "Redshift started with default settings"
#fi



