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
tst cp home/pi/Lircmap.xml /home/pi/Lircmap.xml
tst cp shScripts/firstrun.sh /home/pi/shScripts/firstrun.sh
tst chmod +x /home/pi/shScripts/firstrun.sh
tst cp etc/rc.local /etc/rc.local
tst chmod +x /etc/rc.local
cat << EOT >>/boot/config.txt
# Enabled Lirc
dtoverlay=lirc-rpi
dtparam=gpio_in_pin=25

EOT


exit 0
