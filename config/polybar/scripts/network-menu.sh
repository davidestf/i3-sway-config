#!/bin/bash

# Find available terminal emulator
if command -v alacritty >/dev/null 2>&1; then
    TERMINAL="alacritty"
elif command -v urxvt >/dev/null 2>&1; then
    TERMINAL="urxvt"
elif command -v xterm >/dev/null 2>&1; then
    TERMINAL="xterm"
elif command -v gnome-terminal >/dev/null 2>&1; then
    TERMINAL="gnome-terminal --"
elif command -v terminator >/dev/null 2>&1; then
    TERMINAL="terminator"
else
    notify-send "Error" "No supported terminal emulator found"
    exit 1
fi

# Launch nmtui in the terminal
$TERMINAL -e nmtui
