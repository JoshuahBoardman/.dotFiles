#!/bin/bash

#TODO: May swap to a different discord client

set -euo pipefail
APP=com.discordapp.Discord

# 1) Ensure no old instance is running (flags won't apply otherwise)
flatpak kill "$APP" >/dev/null 2>&1 || true
sleep 0.2

# 2) Prefer native Wayland via Electron/Ozone
export ELECTRON_ENABLE_WAYLAND=1
export OZONE_PLATFORM=wayland

exec flatpak run "$APP" \
  --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer \
  --ozone-platform-hint=wayland
