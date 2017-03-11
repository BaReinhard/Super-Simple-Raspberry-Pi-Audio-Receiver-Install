#!/bin/bash
FILE=/usr/local/bin/Lircmap.xml

if [ -f "$FILE" ];
then
        cp /usr/local/bin/Lircmap.xml ~/.kodi/userdata/Lircmap.xml
	rm /usr/local/bin/Lircmap.xml
	reboot
fi
exit 0
