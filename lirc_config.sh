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
tst cp etc/lirc/lircd.conf /etc/lirc/lircd.conf
tst cp etc/lirc/hardware.conf /etc/lirc/hardware.conf
tst cp usr/local/bin/Lircmap.xml /usr/local/bin/Lircmap.xml
tst cp usr/local/bin/firstrun.sh /usr/local/bin/firstrun.sh
tst chmod +x /usr/local/bin/firstrun.sh
tst cp etc/rc.local /etc/rc.local
tst chmod +x /etc/rc.local
cat << EOT >>/boot/config.txt
# Enabled Lirc
dtoverlay=lirc-rpi
dtparam=gpio_in_pin=25

EOT


exit 0
