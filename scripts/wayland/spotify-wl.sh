#!/bin/bash

# Ensure Wayland/Electron compatibility for Spotify
export ELECTRON_ENABLE_WAYLAND=1
export OZONE_PLATFORM=wayland
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland,x11
#export ELECTRON_FORCE_DEVICE_SCALE_FACTOR=1.5

# Launch Spotify with Wayland window decorations enabled
#exec spotify \
  #--enable-features=WaylandWindowDecorations \
  #--ozone-platform=wayland
  #--force-device-scale-factor=1.5

exec flatpak run com.spotify.Client \
  --enable-features=WaylandWindowDecorations \
  --ozone-platform=wayland \
#  --force-device-scale-factor=1.5
