#!/bin/bash
if pgrep gammastep > /dev/null
then
    pkill gammastep
    notify-send "Night Light Disabled" -t 1000
else
    gammastep -c ~/.config/gammastep/config.ini &
    notify-send "Night Light Enabled" -t 1000
fi
