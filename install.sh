#!/bin/bash

log="./runall.log"
echo "" > $log
echo "1. Install the Raspberry Pi Audio Receiver Car Installation"
echo "2. Install the Raspberry Pi Audio Receiver Home Installation"
echo "3. Install a Custom Raspberry Pi Audio Receiver"
Install="4"
while [ $Install != "1" ] && [ $Install != "2" ] && [ $Install != "3" ];
do
read -p "Which installation would you like to choose? (1/2/3) : " Install

if [ $Install = "1" ]
then
	AirPlay="y"
	Bluetooth="y"
	AP="y"
	Kodi="y"
	Lirc="y"

elif [ $Install = "2" ]
then
        AirPlay="y"
        Bluetooth="y"
        AP="n"
        Kodi="y"
        Lirc="y"

elif [ $Install = "3" ]
then

	AirPlay="AirPlay"
	while [ $AirPlay != "y" ] && [ $AirPlay != "n" ];
	do
		read -p "Do you want AirPlay Enabled? (y/n) : " AirPlay
	done
	Bluetooth="Bluetooth"
	while [ $Bluetooth != "y" ] && [ $Bluetooth != "n" ];
	do
		read -p "Do you want Bluetooth A2DP Enabled? (y/n) : " Bluetooth

	done
	AP="AP"
	while [ $AP != "y" ] && [ $AP != "n" ];
	do
		read -p "Do you want to setup as an Access Point? (Necessary for AirPlay, in location without a Wireless Network) (y/n) : " AP
	done
	Kodi="Kodi"
	while [ $Kodi != "y" ] && [ $Kodi != "n" ];
	do
		read -p "Do you want Kodi installed? (y/n) : " Kodi
	done
	Lirc="Lirc"
	while [ $Lirc != "y" ] && [ $Lirc != "n" ];
	do
		read -p "Do you want to use infrared remotes? (y/n) : " Lirc
	done

else
	echo "Please choose a valid choice"
fi
done
SameName="SameName"
while [ $SameName != "y" ] && [ $SameName != "n" ];
do
	read -p "Do you want all the Devices to use the same name? (y/n) : " SameName
done
if [ $SameName = "y" ]
then
	read -p "Device name: " MYNAME
	APName=$MYNAME
	BluetoothName=$MYNAME
	AirPlayName=$MYNAME
elif [ $SameName = "n" ]
then
	if [ $Bluetooth = "y" ]
	then
		read -p "Bluetooth Device Name: " BluetoothName
	fi
	if [ $AirPlay = "y" ]
	then
		read -p "AirPlay Device Name: " AirPlayName
	fi
	if [ $AP = "y" ]
	then
		read -p "Access Point Device Name: " APName
	fi
fi
if [ $AP = "y" ]
then
read -p "Device WiFi Password: " WIFIPASS
fi
#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi
}
#--------------------------------------------------------------------
chmod +x ./*
echo "Starting @ `date`" | tee -a $log

echo "--------------------------------------------" | tee -a $log
tst ./bt_pa_prep.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
if [ $Bluetooth = "y" ]
then
tst ./bt_pa_install.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
echo "${BluetoothName}" | tst ./bt_pa_config.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
tst ./sound_card_install.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
fi
if [ $AirPlay = "y" ]
then
tst ./airplay_install.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
echo "${AirPlayName}" | tst ./airplay_config.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
fi
if [ $AP = "y" ]
then
tst ./ap_install.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
{ echo "${APName}"; echo "${WIFIPASS}";} | tst ./ap_config.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
fi
if [ $Kodi = "y" ]
then
tst ./kodi_install.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
tst ./kodi_config.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
fi
if [ $Lirc = "y" ]
then
tst ./lirc_install.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
tst ./lirc_config.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
fi
echo "Ending at @ `date`" | tee -a $log
reboot
