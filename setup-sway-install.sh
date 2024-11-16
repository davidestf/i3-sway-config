#!/bin/bash

# Exit on error
set -e

echo "Starting i3 installation and configuration..."

# Update system
echo "Updating package lists..."
sudo apt update

# Install base dependencies
echo "Installing base dependencies..."

sudo apt install -y \
sway \
swaylock \
brightnessctl \
gdm3 \
gammastep \
pavucontrol \
waybar \
rofi \
xwayland \
dunst \
fonts-font-awesome \
lxappearance \
sway-notification-center \
xdg-desktop-portal-wlr \
wofi


# Create necessary directories
echo "Creating directories..."
mkdir -p ~/.config/gammastep
mkdir -p ~/.config/sway
mkdir -p ~/.config/waybar

# Copy configurations
echo "Copying configurations..."
cp -r sway-config/gammastep/* ~/.config/gammastep
cp -r sway-config/sway/* ~/.config/sway
cp -r sway-config/waybar/* ~/.config/waybar




