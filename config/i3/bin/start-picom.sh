#!/bin/bash

# Function to check for running compositors
check_compositor() {
    if pgrep -x "compton" >/dev/null || pgrep -x "xcompmgr" >/dev/null || pgrep -x "picom" >/dev/null; then
        return 0
    else
        return 1
    fi
}

# Kill all possible compositors
killall -q picom compton xcompmgr

# Wait until they're dead
while check_compositor; do
    echo "Waiting for compositors to stop..."
    sleep 1
done

# Clean up any leftover lock files
rm -f /tmp/picom-*.pid
rm -f /tmp/picom.pid
rm -f /tmp/picom_db.*.pid

# Wait a moment
sleep 1

# Start picom with proper config and logging
if ! check_compositor; then
    picom --config ~/.config/picom/picom.conf --log-file ~/.config/picom/picom.log 2>&1 &
    echo "Picom started with PID $!"
else
    echo "Failed to start picom - another compositor is still running"
    exit 1
fi

# Verify picom started successfully
sleep 2
if pgrep -x "picom" >/dev/null; then
    notify-send "Picom" "Started successfully"
else
    notify-send "Picom" "Failed to start"
    exit 1
fi
