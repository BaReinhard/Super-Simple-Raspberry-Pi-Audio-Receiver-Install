#!/bin/bash
# Prompt User for Installation
# Sets Log File
log="./install.log"
# Begins Logging
currentDir=$(
  cd $(dirname "$0")
  pwd
) 
SSPARI_PATH=$currentDir 
echo $SSPARI_PATH
export SSPARI_PATH
if [ $SUDO_USER ]; 
then 
	user=$SUDO_USER;echo 
else 
	echo "Must be run as root user!!" 
	exit 1 
fi
echo "" > $log
echo "1. Install the Raspberry Pi Audio Receiver Car Installation"
echo "2. Install the Raspberry Pi Audio Receiver Home Installation"
echo "3. Install the Raspberry Pi Network Without Internet Installation (For teaching!)"
echo "4. Install the Volumio (Bluetooth Only) Installation"
echo "5. Install a Custom Raspberry Pi Audio Receiver"
Install="0"
while [ $Install != "1" ] && [ $Install != "2" ] && [ $Install != "3" ] && [ $Install != "4" ] && [ $Install != "5" ];
do
read -p "Which installation would you like to choose? (1/2/3/4/5) : " Install
# Car Installation - Previously Raspberry Pi Audio Receiver Install Car Install
if [ $Install = "1" ]
then
	AirPlay="y"
	Bluetooth="y"
	AP="y"
	Kodi="y"
	Lirc="y"
	SoundCardInstall="y"
	GMedia="n"
# Home Installation - Previously Raspberry Pi Audio Receiver Install
elif [ $Install = "2" ]
then
        AirPlay="y"
        Bluetooth="y"
        AP="n"
        Kodi="y"
        Lirc="y"
	SoundCardInstall="y"
	GMedia="y"
# Access Point Install - Previously Network Without Internet
elif [ $Install = "3" ]
then
	AirPlay="n"
        Bluetooth="n"
        AP="y"
        Kodi="n"
        Lirc="n"
	GMedia="n"
	
elif [ $Install = "4" ]
then
	AirPlay="n"
	Bluetooth="y"
	AP="n"
	Kodi="n"
	Lirc="n"
	GMedia="n"
	SoundCardInstall="n"
	
# Custom Install - Allows Users to Choose Installation of various features. Further allowing the use of this project with other ideas aside from Audio Receivers.
elif [ $Install = "5" ]
then
	SNAPCAST="SNAPCAST"
	while [ $SNAPCAST != "y" ] && [ $SNAPCAST != "n" ];
	do
		read -p "Do you want to install SnapCast? (y/n): " SNAPCAST
	done
	if [ $SNAPCAST = "y" ]
	then
		read -p "Would you line to install SnapCast as a Server(s), Client(c), or both (b)?: (s/c/b)" SNAPCAST
	fi
	# Prompts the User to use AirPlay for Streaming (aka shairport-sync)
	AirPlay="AirPlay"
	while [ $AirPlay != "y" ] && [ $AirPlay != "n" ];
	do
		read -p "Do you want AirPlay Enabled? (y/n) : " AirPlay
	done
	# Prompts the User to use Bluetooth for Streaming (aka A2DP)
	Bluetooth="Bluetooth"
	while [ $Bluetooth != "y" ] && [ $Bluetooth != "n" ];
	do
		read -p "Do you want Bluetooth A2DP Enabled? (y/n) : " Bluetooth

	done
	# Prompts the User to use the Raspberry Pi as an Access Point to create a network (needed for AirPlay when no existing network exists)
	AP="AP"
	while [ $AP != "y" ] && [ $AP != "n" ];
	do
		read -p "Do you want to setup as an Access Point? (Necessary for AirPlay, in location without a Wireless Network) (y/n) : " AP
	done
	# Prompts the User to use Kodi as a GUI for a Media Center
	Kodi="Kodi"
	while [ $Kodi != "y" ] && [ $Kodi != "n" ];
	do
		read -p "Do you want Kodi installed? (y/n) : " Kodi
	done
	# Prompts the User to use Lirc for Infrared Remote Support (matricom IR remote already setup for use with Kodi)
	Lirc="Lirc"
	while [ $Lirc != "y" ] && [ $Lirc != "n" ];
	do
		read -p "Do you want to use infrared remotes? (y/n) : " Lirc
	done
	SoundCardInstall="SoundCardInstall"
	while [ $SoundCardInstall != "y" ] && [ $SoundCardInstall != "n" ];
	do
		read -p "Do you want to use a Sound Card? (y/n) : " SoundCardInstall
	done
	GMedia="GMedia"
	while [ $GMedia != "y" ] && [ $GMedia != "n" ];
	do
		read -p "Do you want to setup device as a UPnP Renderer? (y/n) : " GMedia
	done
else
	echo "Please choose a valid choice"
fi
done
# Prompts the User to check whether or not to use individual names for the chosen devices
SameName="SameName"
while [ $SameName != "y" ] && [ $SameName != "n" ];
do
	read -p "Do you want all the Devices to use the same name? (y/n) : " SameName
done
if [ $SameName = "y" ]
then
	# Asks for All Devices Identical Name
	read -p "Device name: " MYNAME
	APName=$MYNAME
	BluetoothName=$MYNAME
	AirPlayName=$MYNAME
	GMediaName=$MYNAME
elif [ $SameName = "n" ]
then	
	# Asks for Bluetooth Device Name
	if [ $Bluetooth = "y" ]
	then
		read -p "Bluetooth Device Name: " BluetoothName
	fi
	# Asks for AirPlay Device Name
	if [ $AirPlay = "y" ]
	then
		read -p "AirPlay Device Name: " AirPlayName
	fi
	# Asks for Access Point Device Name
	if [ $AP = "y" ]
	then
		read -p "Access Point Device Name: " APName
	fi
	if [ $GMedia = "y" ]
	then
		read -p "UPnP Device Name: " GMediaName	
	fi
fi
if [ $AP = "y" ]
then
# Asks for the Access Point Password
read -p "Device WiFi Password: " WIFIPASS
fi
if [ $SoundCardInstall = "y" ]
then
	echo "0. No Sound Card"
	echo "1. HifiBerry DAC Light"
	echo "2. HifiBerry DAC Standard/Pro"
	echo "3. HifiBerry Digi+"
	echo "4. Hifiberry Amp+"
	echo "5. Pi-IQaudIO DAC"
	echo "6. Pi-IQaudIO DAC+, Pi-IQaudIO DACZero, Pi-IQaudIO DAC PRO"
	echo "7. Pi-IQaudIO DigiAMP"
	echo "8. Pi-IQaudIO Digi+"
	echo "9. USB Sound Card"
	echo "10. JustBoom DAC and AMP Cards"
	echo "11. JustBoom Digi Cards"
	SoundCard="SoundCard"
	while [ $SoundCard != "0" ] && [ $SoundCard != "1" ] && [ $SoundCard != "2" ] && [ $SoundCard != "3" ] && [ $SoundCard != "4" ] && [ $SoundCard != "5" ] && [ $SoundCard != "6" ] && [ $SoundCard != "7" ] && [ $SoundCard != "8" ] && [ $SoundCard != "9" ] && [ $SoundCard != "10" ] && [ $SoundCard != "11" ];
	do
		read -p "Which Sound Card are you using? (0/1/2/3/4/5/6/7/8/9/10/11) : " SoundCard
	done
else
	SoundCard="0"
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
# Updates and Upgrades the Raspberry Pi
echo "This is who i am: `whoami`"
echo "--------------------------------------------" | tee -a $log
tst ./bt_pa_prep.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
# If Bluetooth is Chosen, it installs Bluetooth Dependencies and issues commands for proper configuration

if [ $Bluetooth = "y" ]
then
	tst ./bt_pa_install.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
	echo "${BluetoothName}" | tst su ${user} -c ./bt_pa_config.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
fi
if [ $SoundCardInstall = "y" ]
then
	echo "${SoundCard}" | tst ./sound_card_install.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
fi
# If AirPlay is Chosen, it installs AirPlay Dependencies and issues commands for proper configuration
if [ $AirPlay = "y" ]
then
	tst ./airplay_install.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
	{ echo "${AirPlayName}"; echo "${SoundCard}";} | tst ./airplay_config.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
fi
# If Access Point is Chosen, it installs AP Dependencies and issues commands for proper configuration
if [ $AP = "y" ]
then
	tst ./ap_install.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
	{ echo "${APName}"; echo "${WIFIPASS}";} | tst ./ap_config.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
fi
# If Kodi is Chosen, it installs Kodi Dependencies and issues commands for proper configuration
if [ $Kodi = "y" ]
then
	tst ./kodi_install.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
	tst ./kodi_config.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
fi
# If Lirc is Chosen, it installs Lirc Dependencies and issues commands for proper configuration
if [ $Lirc = "y" ]
then
	tst ./lirc_install.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
	tst ./lirc_config.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
fi
# If GMedia is Chosen, it installs  GMedia Dependencies and issues commands for proper configuration
if [ $GMedia = "y" ]
then
	echo "${GMediaName}" | tst ./gmrender_install.sh | tee -a $log
	echo "--------------------------------------------" | tee -a $log
fi
if [ $SNAPCAST != "n" ]
then
	echo "--------------SNAP CAST INSTALL--------------------" | tee -a $log
	echo "${SNAPCAST}" | tst su ${user} -c ./snapcast_install.sh | tee -a $log
	echo "----------------------------------------------------" | tee -a $log
fi
echo "Ending at @ `date`" | tee -a $log
cat << EOT > install_choices
Bluetooth = $Bluetooth
AirPlay = $AirPlay
AP = $AP
Kodi = $Kodi
Lirc = $Lirc
SoundCardInstall = $SoundCardInstall
GMedia = $GMedia
EOT
reboot
