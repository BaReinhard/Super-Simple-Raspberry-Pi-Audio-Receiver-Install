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
cat <<EOT >/boot/cmdline.txt
dwc_otg.lpm_enable=0 console=serial0,115200 console=tty3 loglevel=0 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait logo.nologo quiet splash vt.global_cursor_default=0 consoleblank=0
EOT
tst touch /home/pi/.hushlogin


exit 0
