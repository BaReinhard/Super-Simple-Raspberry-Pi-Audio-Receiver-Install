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
tst usermod -a -G lp kodi
tst usermod -a -G pulse-access,audio root
tst adduser kodi pulse-access

# Faster Boot
cat <<EOT >/boot/cmdline.txt
dwc_otg.lpm_enable=0 console=serial0,115200 console=tty3 loglevel=0 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait logo.nologo quiet splash vt.global_cursor_default=0 consoleblank=0
EOT
touch /home/pi/.hushlogin


exit 0
