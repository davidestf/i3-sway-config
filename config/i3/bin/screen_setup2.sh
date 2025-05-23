#!/bin/bash


# Set the laptop monitor (eDP-1) at the bottom
# Set the external monitor (DP-3-2) above it
xrandr --output eDP-1 --primary --mode 1920x1200 --pos 0x1440 \
       --output DP-3-1 --mode 2560x1440 --pos 0x0


# Set per-monitor DPI
xrandr --output eDP-1 --dpi 120
xrandr --output DP-3-1 --dpi 100

# Optional: Center the wider screen above the laptop
# Calculation: (2560 - 1920) / 2 = 320 pixels offset
# xrandr --output eDP-1 --primary --mode 1920x1200 --pos 320+1440 \
#        --output DP-3-2 --mode 2560x1440 --pos 0+0
