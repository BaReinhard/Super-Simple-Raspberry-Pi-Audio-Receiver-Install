#!/bin/bash

if [ $SUDO_USER ]; 
then 
	user=$SUDO_USER;echo 
else 
	echo "Must be run as root user!!" 
	exit 1 
fi
if [ -z "$BluetoothName" ]
then
 read -p "Bluetooth device name: " BluetoothName
fi
if [ -z "$exc" ]
then 
    source functions.sh
    source dependencies.sh
fi


exc cd ~
exc remove_dir pulseaudio
exc git clone --branch v6.0 https://github.com/pulseaudio/pulseaudio

exc cd ~
exc cd pulseaudio
exc sudo ./bootstrap.sh
exc sudo make
exc sudo make install
exc sudo ldconfig
exc sudo cp /etc/pulsebackup/* /etc/pulse