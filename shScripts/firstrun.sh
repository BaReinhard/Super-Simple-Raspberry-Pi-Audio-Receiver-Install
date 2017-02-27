#!/bin/bash
FILE=/home/pi/Lircmap.xml

if [ -f "$FILE" ];
then
        mv /home/pi/Lircmap.xml /home/kodi/.kodi/userdata/Lircmap.xml
	reboot
fi
exit 0
