# Check if bluetooth is powered on
if ! bluetoothctl show | grep -q "Powered: yes"; then
    echo "$COLOR_DISCONNECTED$ICON Off%{F-}"
    exit 0
fi

# Get list of connected devices
connected_devices=$(bluetoothctl devices Connected | while read -r _ mac name; do
    if [ ! -z "$name" ]; then
        echo -n "$COLOR_CONNECTED$name%{F-}, "
    fi
done)

# Remove trailing comma and space
connected_devices=${connected_devices%, }

if [ -z "$connected_devices" ]; then
    # Check for paired devices when no connected devices
    paired_devices=$(bluetoothctl devices Paired | wc -l)
    if [ "$paired_devices" -gt 0 ]; then
        echo "$COLOR_PAIRED$ICON $paired_devices paired%{F-}"
    else
        echo "$COLOR_DISCONNECTED$ICON No devices%{F-}"
    fi
else
    echo "$COLOR_CONNECTED$ICON $connected_devices%{F-}"
fi
