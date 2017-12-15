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
tst usermod -a -G input kodi
tst usermod -a -G lp kodi
tst usermod -a -G pulse-access,audio root
tst adduser kodi pulse-access
patch /etc/default/kodi << EOT
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
tst cp boot/cmdline.txt /boot/cmdline.txt
touch ~/.hushlogin


exit 0
