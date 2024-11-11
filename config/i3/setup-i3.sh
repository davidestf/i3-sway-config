
# Create necessary directories
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0
mkdir -p ~/.themes
mkdir -p ~/.icons
mkdir -p ~/.config/rofi
mkdir -p ~/.config/dunst
mkdir -p ~/.config/alacritty

# Install required packages
sudo apt install -y \
    lxappearance \
    nitrogen \
    picom \
    rofi \
    dunst \
    gtk2-engines-murrine \
    gtk2-engines-pixbuf \
    arc-theme \
    papirus-icon-theme
    redshift \
    geoclue-2.0
#sudo apt install conky-all lm-sensors hddtemp
#sudo apt-get install feh
#sudo apt install dunst
#sudo apt install bluez blueman
# network-manager
#pulsemixer lasamixer



# Download Nordic GTK theme
git clone https://github.com/EliverLara/Nordic.git ~/.themes/Nordic

# Download Nordzy icons
git clone https://github.com/alvatip/Nordzy-icon.git
cd Nordzy-icon
./install.sh

# Configure GTK theme
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

# Copy settings to GTK4
cp ~/.config/gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini
