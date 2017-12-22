#!/bin/bash

if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi




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

