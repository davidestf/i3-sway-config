#!/bin/bash

# Define displays
LAPTOP="eDP-1"
EXTERNAL="DP-3-1"

# Keep laptop screen where it is (primary at 0x0)
xrandr --output "$LAPTOP" --primary --mode 1920x1200 --pos 0x0 \
       --output "$EXTERNAL" --mode 2560x1440 --pos 0x-1440

# Debug output
echo "Laptop screen: 1920x1200 at 0x0"
echo "External monitor: 2560x1440 at 0x-1440"
