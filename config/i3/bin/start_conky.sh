#!/bin/bash

# Kill existing conky
killall conky

# Wait a moment
sleep 1

# Start conky
conky -c ~/.config/i3/conky/conky.conf &

