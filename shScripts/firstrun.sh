#!/bin/bash
FILE=/home/pi/Lircmap.xml

if [ -f "$FILE" ];
then
        cp /home/pi/Lircmap.xml /home/kodi/.kodi/userdata/Lircmap.xml
	rm /home/pi/Lircmap.xml
	reboot
fi
exit 0
