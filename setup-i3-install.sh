#!/bin/bash

# Exit on error
set -e

echo "Starting i3 installation and configuration..."

# Update system
echo "Updating package lists..."
#sudo apt update

# Install base dependencies
echo "Installing base dependencies..."
sudo apt install -y \
    alacritty \
    alsa-utils \
    gdm3 \
    i3 \
    i3status \
    clipman \
    compton \
    diodon \
    gnome-screenshot \
    polybar \
    terminator \
    lxappearance \
    picom \
    rofi \
    dunst \
    psmisc \
    gtk2-engines-murrine \
    gtk2-engines-pixbuf \
    arc-theme \
    papirus-icon-theme \
    pulseaudio \
    redshift \
    geoclue-2.0 \
    conky-all \
    lm-sensors \
    feh \
    bluez \
    blueman \
    network-manager \
    pulsemixer

# Create necessary directories
echo "Creating directories..."
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0
mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/picom
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/terminator
mkdir -p ~/.config/dunst
mkdir -p ~/.config/rofi
mkdir -p ~/.themes
mkdir -p ~/.icons
mkdir -p ~/.config/i3/bin
mkdir -p ~/.config/i3/conky

# Copy configurations
echo "Copying configurations..."
cp -r config/i3/* ~/.config/i3/
cp -r config/polybar/* ~/.config/polybar/
cp -r config/picom/* ~/.config/picom/
cp -r config/alacritty/* ~/.config/alacritty/
cp -r config/terminator/* ~/.config/terminator/
cp -r config/rofi/* ~/.config/rofi/
cp config/.dotfiles/.Xresources ~/

# Set execute permissions for scripts
chmod +x ~/.config/i3/bin/*
chmod +x ~/.config/i3/setup-i3.sh
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/scripts/*

# Download and install Nordic theme
echo "Installing Nordic GTK theme..."
if [ ! -d ~/.themes/Nordic ]; then
    git clone https://github.com/EliverLara/Nordic.git ~/.themes/Nordic
fi

# Download and install Nordzy icons
echo "Installing Nordzy icons..."
if [ ! -d ~/.icons/Nordzy ]; then
    git clone https://github.com/alvatip/Nordzy-icon.git /tmp/Nordzy-icon
    cd /tmp/Nordzy-icon
    ./install.sh
    cd -
    rm -rf /tmp/Nordzy-icon
fi

# Configure GTK theme
echo "Configuring GTK theme..."
cat > ~/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-theme-name=Nordic
gtk-icon-theme-name=Nordzy
gtk-font-name=Sans 10
gtk-application-prefer-dark-theme=1
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintslight
gtk-xft-rgba=rgb
EOF

# Copy GTK settings to GTK4
cp ~/.config/gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini

echo "Installation complete! Please log out and log back in to start using i3."

# Log out and select i3 from your display manager
# Use lxappearance to fine-tune your theme settings
