#Install PipeWire
sudo apt install -y \
    pipewire \
    pipewire-audio \
    pipewire-pulse \
    wireplumber \
    libspa-0.2-bluetooth \
    pipewire-jack \
    libspa-0.2-jack \
    pipewire-alsa \
    libpipewire-0.3-common \
    libpipewire-0.3-modules \
    gstreamer1.0-pipewire

#Stop/disable PulseAudio
systemctl --user stop pulseaudio.service pulseaudio.socket
systemctl --user mask pulseaudio

#Disable PulseAudio 
mkdir -p ~/.config/pulse
echo "autospawn = no" > ~/.config/pulse/client.conf

#Enable PipeWire
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse wireplumber

#Create configuration directories
#mkdir -p ~/.config/pipewire/
#mkdir -p ~/.config/wireplumber/

#Copy default configurations
#cp -r /usr/share/pipewire/* ~/.config/pipewire/
#cp -r /usr/share/wireplumber/* ~/.config/wireplumber/
