#!/bin/bash
if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi
save_original /etc/lirc/lircd.conf
exc cp etc/lirc/lircd.conf /etc/lirc/lircd.conf
save_original /etc/lirc/hardware.conf
exc cp etc/lirc/hardware.conf /etc/lirc/hardware.conf
exc cp usr/local/bin/Lircmap.xml /usr/local/bin/Lircmap.xml
exc cp usr/local/bin/firstrun.sh /usr/local/bin/firstrun.sh
exc chmod +x /usr/local/bin/firstrun.sh
save_original /etc/rc.local
exc cp etc/rc.local /etc/rc.local
exc chmod +x /etc/rc.local
save_original /boot/config.txt
cat << EOT >> /boot/config.txt
# Enabled Lirc
dtoverlay=lirc-rpi
dtparam=gpio_in_pin=25
EOT
