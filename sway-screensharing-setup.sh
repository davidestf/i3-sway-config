#!/bin/bash

sudo apt install -y \
    xdg-desktop-portal \
    xdg-desktop-portal-wlr \
    xdg-desktop-portal-gtk \
    pipewire \
    slurp \
    grim \
    swayidle


mkdir -p ~/.config/xdg-desktop-portal
mkdir -p ~/.config/systemd/user
mkdir -p ~/.config/environment.d

# XDG portal
cat > ~/.config/xdg-desktop-portal/portals.conf << EOF
[preferred]
default=gtk
org.freedesktop.impl.portal.Screencast=wlr
org.freedesktop.impl.portal.Screenshot=wlr
EOF

# Systemd service
cat > ~/.config/systemd/user/xdg-desktop-portal-wlr.service << EOF
[Unit]
Description=Portal service (wlroots implementation)
After=graphical-session.target
Requires=graphical-session.target

[Service]
Type=dbus
BusName=org.freedesktop.impl.portal.desktop.wlr
ExecStart=/usr/libexec/xdg-desktop-portal-wlr
Restart=on-failure

[Install]
WantedBy=graphical-session.target
EOF

# Environment file
cat > ~/.config/environment.d/env.conf << EOF
MOZ_ENABLE_WAYLAND=1
XDG_CURRENT_DESKTOP=sway
XDG_SESSION_TYPE=wayland
EOF

# Add to Sway config
cat >> ~/.config/sway/config << EOF

# Screen sharing
exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
exec systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# XDG portal support
exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP
exec hash dbus-update-activation-environment 2>/dev/null && \
     dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP

# Start XDG portals
exec /usr/libexec/xdg-desktop-portal
exec /usr/libexec/xdg-desktop-portal-wlr
EOF

# Reload services
systemctl --user daemon-reload
systemctl --user enable --now xdg-desktop-portal-wlr

echo "Setup complete. Please restart Sway for changes to take effect."
