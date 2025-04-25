#!/usr/bin/env bash

VERSION="1.0"
LOG_FILE="$HOME/YouTubeLauncher.log"

# Log output
exec 1>"${LOG_FILE}" 2>&1

echo "Launching YouTube - VERSION $VERSION"

# Ensure Flatpak is available
command -v flatpak >/dev/null 2>&1 || {
    echo "ERROR: Flatpak not found. Please install Flatpak and try again.";
    exit 1;
}

# Grant Chrome access to udev for controller/multimedia support
flatpak --user override --filesystem=/run/udev:ro com.google.Chrome

# Launch Chrome in app mode (kiosk-style)
flatpak run --branch=stable --arch=x86_64 --command=/app/bin/chrome --file-forwarding com.google.Chrome @@u @@ \
--kiosk \
--start-fullscreen \
--app=https://youtube.com/tv
