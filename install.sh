#!/bin/bash
# Prompt User for Installation


currentDir=$(
  cd $(dirname "$0")
  pwd
) 

SSPARI_PATH=$currentDir 
export SSPARI_PATH
SSPARI_BACKUP_PATH="$SSPARI_PATH/backup_files"
export SSPARI_BACKUP_PATH
touch "$SSPARI_BACKUP_PATH/files"
if [ $SUDO_USER ]; 
then 
	user=$SUDO_USER;echo 
else 
	echo "Must be run as root user!!" 
	exit 1 
fi

# Add Environment Variables, used for uninstallation
HOME_PROF="/home/$user/.profile"
save_original $HOME_PROF
echo "export SSPARI_PATH=$SSPARI_PATH" >> "/home/$user/.profile"
echo "export SSPARI_BACKUP_PATH=$SSPARI_PATH/backup_files" >> "/home/$user/.profile"


cd "$currentDir"
chmod -R 777 .
# Set up file-based logging
exec 1> >(tee install.log)
source functions.sh
source dependencies.sh
restore_originals
log "Select Your Install Options"
# Begins Logging

installlog "1. Install the Raspberry Pi Audio Receiver Car Installation"
installlog "2. Install the Raspberry Pi Audio Receiver Home Installation"
installlog "3. Install the Raspberry Pi Network Without Internet Installation (For teaching!)"
installlog "4. Install the Bluetooth Only Installation"
installlog "5. Install the Snapcast Installation (BETA), choose from Snapcast Server, Client, or Both (Requires Minor Configuration)"
installlog "6. Install a Custom Raspberry Pi Audio Receiver"

Install="0"
while true
do
	read -p "Which installation would you like to choose? (1/2/3/4/5/6) : " Install
	case "$Install" in
	1)
	# Car Installation - Previously Raspberry Pi Audio Receiver Install Car Install
		AirPlay="y"
		Bluetooth="y"
		AP="y"
		Kodi="y"
		Lirc="y"
		SoundCardInstall="y"
		GMedia="n"
		break
	;;
	2)
	# Home Installation - Previously Raspberry Pi Audio Receiver Install
		AirPlay="y"
		Bluetooth="y"
		AP="n"
		Kodi="y"
		Lirc="y"
		SoundCardInstall="y"
		GMedia="y"
		break
	;;
	3)
	# Access Point Install - Previously Network Without Internet
		AirPlay="n"
		Bluetooth="n"
		AP="y"
		Kodi="n"
		Lirc="n"
		GMedia="n"
		break
	;;
	4)
		AirPlay="n"
		Bluetooth="y"
		AP="n"
		Kodi="n"
		Lirc="n"
		GMedia="n"
		SoundCardInstall="n"
		break
	;;
	5)
	# Custom Install - Allows Users to Choose Installation of various features.
	# Further allowing the use of this project with other ideas aside from Audio Receivers.
		AirPlay="y"
		Bluetooth="y"
		AP="n"
		Kodi="n"
		Lirc="n"
		GMedia="n"
		SNAPCAST="y"
		SoundCardInstall="y"
		break
	;;
	6)
		SNAPCAST="n"
		YesNo "Do you want to install SnapCast? (y/n): " && SNAPCAST="y"
		# Prompts the User to use AirPlay for Streaming (aka shairport-sync)
		AirPlay="n"
		YesNo "Do you want AirPlay Enabled? (y/n) : " && AirPlay="y"
		# Prompts the User to use Bluetooth for Streaming (aka A2DP)
		Bluetooth="n"
		YesNo "Do you want Bluetooth A2DP Enabled? (y/n) : " && Bluetooth="y"
		# Prompts the User to use the Raspberry Pi as an Access Point to create a network
		# (needed for AirPlay when no existing network exists)
		AP="n"
		YesNo "Do you want to setup as an Access Point? (Necessary for AirPlay, in location without a Wireless Network) (y/n) : " && AP="y"
		# Prompts the User to use Kodi as a GUI for a Media Center
		Kodi="n"
		YesNo "Do you want Kodi installed? (y/n) : " && Kodi="y"
		# Prompts the User to use Lirc for Infrared Remote Support
		# (matricom IR remote already setup for use with Kodi)
		Lirc="n"
		YesNo "Do you want to use infrared remotes? (y/n) : " && Lirc="y"
		SoundCardInstall="n"
		YesNo "Do you want to use a Sound Card? (y/n) : " && SoundCardInstall="y"
		GMedia="n"
		YesNo "Do you want to setup device as a UPnP Renderer? (y/n) : " && GMedia="y"
		break
	;;
	*)
		echo "Please choose a valid choice"
	esac
done

if [ "$SNAPCAST" = "y" ]
then
	while true
	do
		read -p "Would you like to install SnapCast as a Server(s), Client(c), or both (b)?: (s/c/b) " SNAPCAST
		case "$SNAPCAST" in
		[bB]*) SNAPCAST="b"; break;
		;;
		[cC]*) SNAPCAST="c"; break;
		;;
		[sS]*) SNAPCAST="s"; break;
		;;
		*) echo "Please enter a valid choice";
		;;
		esac
	done
	while true
	do
		read -p "Would you like to install Librespot (Warning: No Longer Maintained, install time: long) (y/n): " LIBRESPOT
		case "$LIBRESPOT" in
		[yY]*) LIBRESPOT="y"; break;
		;;
		[nN]*) LIBRESPOT="n"; break;
		;;
		*) echo "Please enter a valid choice";
		;;
		esac
	done
fi
# Prompts the User to check whether or not to use individual names for the chosen devices
SameName="n"
YesNo "Do you want all the Devices to use the same name? (y/n) : " && SameName="y"
if [ "$SameName" = "y" ]
then
	# Asks for All Devices Identical Name
	read -p "Device name: " MYNAME
	APName=$MYNAME
	BluetoothName=$MYNAME
	AirPlayName=$MYNAME
	GMediaName=$MYNAME
	SNAPNAME=$MYNAME
elif [ "$SameName" = "n" ]
then
	# Asks for Bluetooth Device Name
	if [ "$Bluetooth" = "y" ]
	then
		read -p "Bluetooth Device Name: " BluetoothName
	fi
	# Asks for AirPlay Device Name
	if [ "$AirPlay" = "y" ]
	then
		read -p "AirPlay Device Name: " AirPlayName
	fi
	# Asks for Access Point Device Name
	if [ "$AP" = "y" ]
	then
		read -p "Access Point Device Name: " APName
	fi
	if [ "$GMedia" = "y" ]
	then
		read -p "UPnP Device Name: " GMediaName
	fi
	if [ "$SNAPCAST" != "n" ]
	then
	        read -p "Snapcast Device Name: " SNAPNAME
        fi
fi

if [ "$AP" = "y" ]
then
	# Asks for the Access Point Password
	read -p "Device WiFi Password: " WIFIPASS
fi

if [ "$AirPlay" = "y" ]
then
	AirPlaySecured="n"
	AirPlayPass=""
	# Asks user if AirPlay password should be set
	YesNo "Do you want to use an AirPlay password? (y/n) : " && AirPlaySecured="y"
	# Prompts user for AirPlay password
	if [ "$AirPlaySecured" = "y" ]
	then
		read -p "Device AirPlay password: " AirPlayPass
	fi
fi

if [ "$SoundCardInstall" = "y" ]
then
	installlog "0. No Sound Card"
	installlog "1. HifiBerry DAC Light"
	installlog "2. HifiBerry DAC Standard/Pro"
	installlog "3. HifiBerry Digi+"
	installlog "4. Hifiberry Amp+"
	installlog "5. Pi-IQaudIO DAC"
	installlog "6. Pi-IQaudIO DAC+, Pi-IQaudIO DACZero, Pi-IQaudIO DAC PRO"
	installlog "7. Pi-IQaudIO DigiAMP"
	installlog "8. Pi-IQaudIO Digi+"
	installlog "9. USB Sound Card"
	installlog "10. JustBoom DAC and AMP Cards"
	installlog "11. JustBoom Digi Cards"
	SoundCard="SoundCard"
	while true
	do
		read -p "Which Sound Card are you using? (0/1/2/3/4/5/6/7/8/9/10/11) : " SoundCard
		case "$SoundCard" in
		[0-9]|10|11)
			break
		;;
		*)
			echo "Please enter a valid choice"
		;;
		esac
	done
else
	SoundCard="0"
fi

chmod +x ./*.sh
# Updates and Upgrades the Raspberry Pi

log "Updating via Apt-Get"
apt-get update -y &> /dev/null
log "Upgrading via Apt-Get"
apt-get upgrade -y &> /dev/null


# If Bluetooth is Chosen, it installs Bluetooth Dependencies and issues commands for proper configuration
if [ "$Bluetooth" = "y" ]
then
	export BluetoothName
	run ./bt_pa_install.sh
	VOL_USER=`cat /etc/os-release | grep VOLUMIO_ARCH | sed "s/VOLUMIO_ARCH=//"`
	if [ "$VOL_USER" = "\"arm\"" ]
	then
		vol_groups=`su $user -c groups`
		exc usermod -aG "sudo" $user
		list=`groups $user`
                sed -i "s/volumio ALL=(ALL) ALL/volumio ALL=(ALL) NOPASSWD: ALL/" /etc/sudoers
		run su ${user} -c ./bt_pa_config.sh
		sudo usermod -G "" $user
		for _dep in ${list[@]}; do     sudo usermod -aG "$_dep" volumio; done
		sed -i "s/volumio ALL=(ALL) NOPASSWD: ALL/volumio ALL=(ALL) ALL/" /etc/sudoers
		sed -i "s/$user ALL=(ALL) NOPASSWD: ALL//" /etc/sudoers.d/010_pi-nopasswd
	fi
	run su ${user} -c ./bt_pa_config.sh


fi
if [ "$VOLUMIO" = "y" ]
then
	export BluetoothName
	
	
fi

if [ "$SoundCardInstall" = "y" ]
then
	export SoundCard
	run ./sound_card_install.sh 
fi

# If AirPlay is Chosen, it installs AirPlay Dependencies and issues commands for proper configuration
if [ "$AirPlay" = "y" ]
then
	export SoundCard
	export AirPlayPass
	export AirPlayName
	export AirPlay
	run ./airplay_install.sh 
	run ./airplay_config.sh 
fi



# If Kodi is Chosen, it installs Kodi Dependencies and issues commands for proper configuration
if [ "$Kodi" = "y" ]
then
	run ./kodi_install.sh 
	run ./kodi_config.sh
fi

# If Lirc is Chosen, it installs Lirc Dependencies and issues commands for proper configuration
if [ "$Lirc" = "y" ]
then
	run ./lirc_install.sh
	run ./lirc_config.sh
fi

# If GMedia is Chosen, it installs  GMedia Dependencies and issues commands for proper configuration
if [ "$GMedia" = "y" ]
then
	export GMediaName
	run ./gmrender_install.sh
fi

if [ "$SNAPCAST" != "n" ]
then
	export SNAPCAST
	export SNAPNAME
	export AirPlay	
	export LIBRESPOT
	run su ${user} -c ./snapcast_install.sh
fi

# If Access Point is Chosen, it installs AP Dependencies and issues commands for proper configuration
if [ "$AP" = "y" ]
then
	export APName
	export WIFIPASS
	run ./ap_install.sh 
	run ./ap_config.sh 
fi


run cat << EOT > install_choices
Bluetooth = $Bluetooth
AirPlay = $AirPlay
AP = $AP
Kodi = $Kodi
Lirc = $Lirc
SoundCardInstall = $SoundCardInstall
GMedia = $GMedia
Snapcast = $SNAPCAST
EOT

log You should now reboot
