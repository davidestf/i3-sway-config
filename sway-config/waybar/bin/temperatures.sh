#!/bin/bash


# Get CPU temperature
cpu_temp=$(sensors | grep 'CPU' | awk '{print $2}' | sed 's/+//' | sed 's/°C//')

# Get GPU temperature (if you have AMD GPU)
gpu_temp=$(sensors | grep 'edge' | awk '{print $2}' | sed 's/+//' | sed 's/°C//')

# Format output as JSON for Waybar
echo "{\"text\": \"CPU: ${cpu_temp}°C GPU: ${gpu_temp}°C\", \"tooltip\": \"$(sensors)\"}"
