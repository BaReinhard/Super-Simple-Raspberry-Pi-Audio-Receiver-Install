#!/bin/bash

source functions.sh
source dependencies.sh


# Update

apt_update apt-get update -q=2 -y

# Upgrade the distro
apt_upgrade apt-get upgrade -q=2 -y


for _dep in ${BT_DEPS[@]}; do
    apt_install $_dep;
done

# Create users and priviliges for Bluez-Pulse Audio interaction - most should already exist
exc addgroup --system pulse 
exc adduser --system --ingroup pulse --home /var/run/pulse pulse
exc addgroup --system pulse-access
exc adduser pulse audio
exc adduser root pulse-access
exc adduser pulse lp

