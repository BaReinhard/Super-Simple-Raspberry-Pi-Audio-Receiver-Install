#!/bin/bash

#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi	
}
#--------------------------------------------------------------------

# Install Pulse Audio & Bluez
tst apt-get install bluez pulseaudio pulseaudio-module-bluetooth -y

# Install dbus for python
tst apt-get install python-dbus -y

# Install espeak
tst apt-get install -qy espeak

# Create users and priviliges for Bluez-Pulse Audio interaction - most should already exist
tst addgroup --system pulse
tst adduser --system --ingroup pulse --home /var/run/pulse pulse
tst addgroup --system pulse-access
tst adduser pulse audio
tst adduser root pulse-access
tst adduser pulse lp

echo "Done! You should reboot now"
