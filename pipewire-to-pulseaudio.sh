#!/bin/bash

# Remove PipeWire configurations
rm -rf ~/.config/pipewire/
sudo rm -rf /etc/pipewire/

# Remove PulseAudio configurations
rm -rf ~/.config/pulse/
sudo rm -rf /etc/pulse/

# Remove Bluetooth configurations
sudo rm -rf /etc/bluetooth/

# Install PulseAudio
sudo dnf install -y --allowerasing pulseaudio

# Remove Bluez
sudo dnf remove -y bluez

# Install PulseAudio Bluetooth module
sudo dnf install -y --allowerasing pulseaudio-module-bluetooth

# Disable PipeWire services
systemctl --user stop pipewire
systemctl --user stop pipewire.socket
systemctl --user stop wireplumber
systemctl --user disable pipewire
systemctl --user disable pipewire.socket
systemctl --user disable wireplumber
sudo systemctl --global disable pipewire
sudo systemctl --global disable pipewire.socket
sudo systemctl --global disable wireplumber

# Enable PulseAudio service
systemctl --user enable pulseaudio
sudo systemctl --global enable pulseaudio

echo "Please reboot your system for the changes to take effect. Would you like to reboot now? (y/n)"
read -r answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  sudo reboot
fi
