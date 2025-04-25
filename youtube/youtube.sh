#!/usr/bin/env bash

APPNAME="YouTube"
APPURL="https://youtube.com/"
VERSION="1.1"
LOG_DIR="$(dirname "$0")/../logs"
LOG_FILE="$LOG_DIR/$APPNAME.log"

# Ensure the logs directory exists
mkdir -p "$LOG_DIR"

# Log output
exec 1>"${LOG_FILE}" 2>&1

echo "Launching $APPNAME - VERSION $VERSION"

# Ensure that Chrome flatpak is installed
if ! flatpak list | grep -q "com.google.Chrome"; then
    echo "ERROR: Chrome Flatpak not installed!"
    exit 1
fi

# Grant Chrome access to udev for controller/multimedia support
flatpak --user override --filesystem=/run/udev:ro com.google.Chrome

# Launch Chrome in app mode (kiosk-style)
flatpak run --branch=stable --arch=x86_64 --command=/app/bin/chrome --file-forwarding com.google.Chrome @@u @@ \
--kiosk \
--start-fullscreen \
--app=$APPURL

ret=$?
echo "$(date '+%Y-%m-%d %H:%M:%S') - $APPNAME exited with code $ret"
exit $ret
