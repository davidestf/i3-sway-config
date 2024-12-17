#!/bin/bash

echo "Current Screen Configuration:"
echo "============================"
xrandr | grep -w "connected"

echo -e "\nDetailed Screen Information:"
echo "============================"
# Get external monitor resolution
EXTERNAL_RES=$(xrandr | grep "DP-3-1" | grep -oP '\d+x\d+' | head -n1)
EXTERNAL_HEIGHT=$(echo $EXTERNAL_RES | cut -d'x' -f2)

echo "External Monitor (DP-3-1):"
echo "Resolution: $EXTERNAL_RES"
echo "Height: $EXTERNAL_HEIGHT"

# Get laptop resolution
LAPTOP_RES=$(xrandr | grep "eDP-1" | grep -oP '\d+x\d+' | head -n1)

echo -e "\nLaptop Screen (eDP-1):"
echo "Resolution: $LAPTOP_RES"

echo -e "\nRecommended Position Values:"
echo "External: --pos 0x0"
echo "Laptop: --pos 0x$EXTERNAL_HEIGHT"

echo -e "\nCurrent Positions:"
xrandr --verbose | grep -A1 "connected" | grep -v "connected" | grep "+"
swaymsg -t get_outputs 
