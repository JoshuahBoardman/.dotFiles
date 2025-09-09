#!/bin/bash

# Ensure Wayland/Electron compatibility for Spotify
export ELECTRON_ENABLE_WAYLAND=1
export OZONE_PLATFORM=wayland
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland,x11

# Launch Spotify with Wayland window decorations enabled
exec spotify \
  --enable-features=WaylandWindowDecorations \
  --ozone-platform=wayland
