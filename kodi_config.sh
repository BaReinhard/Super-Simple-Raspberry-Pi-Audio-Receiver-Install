#!/bin/bash

if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi
exc usermod -a -G input kodi
exc usermod -a -G lp kodi
exc usermod -a -G pulse-access,audio root
exc adduser kodi pulse-access
exc patch /etc/default/kodi << EOT
@@ -1,5 +1,5 @@
 # Set this to 1 to enable startup
-ENABLED=0
+ENABLED=1
 
 # The user to run Kodi as
 USER=kodi

EOT
# Add gpu_mem=256 to config.txt for use with Kodi
echo gpu_mem=256 >> /boot/config.txt
# Faster Boot
exc cp boot/cmdline.txt /boot/cmdline.txt
exc touch ~/.hushlogin



