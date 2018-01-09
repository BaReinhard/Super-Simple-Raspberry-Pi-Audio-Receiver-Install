#!/bin/bash

if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi


VERSION=`cat /etc/os-release | grep VERSION= | head -1 | sed "s/VERSION=//"`


if [ "$VERSION" = "\"8 (jessie)\"" ]
then
    log "Raspbian Jessie Found"
    for _dep in ${JESSIE_BT_DEPS[@]}; do
        apt_install $_dep;
        remove_file /etc/dhcpcd.conf
    done
elif [ "$VERSION" = "\"9 (stretch)\"" ]
then
    log "Raspbian Stretch Found"
    for _dep in ${STRETCH_BT_DEPS[@]}; do
        apt_install $_dep;
    done
else
    log "You are running an unsupported VERSION of RASPBIAN"
fi
for _dep in ${BT_DEPS[@]}; do
    apt_install $_dep;
     remove_file /etc/dhcpcd.conf
done

# Create users and priviliges for Bluez-Pulse Audio interaction - most should already exist
exc addgroup --system pulse 
exc adduser --system --ingroup pulse --home /var/run/pulse pulse
exc addgroup --system pulse-access
exc adduser pulse audio
exc adduser root pulse-access
exc adduser pulse lp

