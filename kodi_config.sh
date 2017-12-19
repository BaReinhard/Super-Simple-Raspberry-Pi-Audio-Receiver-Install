#!/bin/bash

if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi
exc adduser kodi
exc adduser kodi pulse-access
exc usermod -a -G input kodi
exc usermod -a -G lp kodi
exc usermod -a -G pulse-access,audio root

save_original /etc/default/kodi
exc sed -i "s/ENABLED=0/ENABLED=1/" /etc/default/kodi 
# Add gpu_mem=256 to config.txt for use with Kodi
echo gpu_mem=256 >> /boot/config.txt
# Faster Boot
save_original /boot/cmdline.txt
exc cp boot/cmdline.txt /boot/cmdline.txt
exc touch ~/.hushlogin



