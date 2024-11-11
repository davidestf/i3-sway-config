#!/bin/bash

# Check if notify-send is available
if ! command -v notify-send &> /dev/null; then
    sudo apt install -y libnotify-bin
fi

if bluetoothctl show | grep -q "Powered: no"; then
    bluetoothctl power on
    notify-send -u normal "Bluetooth" "Bluetooth turned ON" -i bluetooth
else
    # Disconnect all devices before turning off
    bluetoothctl devices Connected | cut -d' ' -f2 | while read -r mac; do
        bluetoothctl disconnect "$mac"
    done
    bluetoothctl power off
    notify-send -u normal "Bluetooth" "Bluetooth turned OFF" -i bluetooth
fi

# Force polybar to update this module
pkill -SIGRTMIN+1 polybar
