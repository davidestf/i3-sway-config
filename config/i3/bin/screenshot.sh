#!/bin/bash

# Full screenshot
if [ "$1" == "full" ]; then
    gnome-screenshot -f ~/Pictures/screenshots/%Y-%m-%d_%H-%M-%S_full.png
# Current window
elif [ "$1" == "current" ]; then
    gnome-screenshot -w -f ~/Pictures/screenshots/%Y-%m-%d_%H-%M-%S_window.png
# Selection
else
    gnome-screenshot -a -f ~/Pictures/screenshots/%Y-%m-%d_%H-%M-%S_selection.png
fi
