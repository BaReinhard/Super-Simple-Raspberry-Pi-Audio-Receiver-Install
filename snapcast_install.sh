#!/bin/bash
if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi
if [ $SUDO_USER ]; then user=$SUDO_USER ; else user=`whoami`; fi
if [ -z "$AirPlay" ]
then
	while true
	do
		read -p "Do you have AirPlay installed?: (y/n) " AirPlay
		case "$AirPlay" in
		[yY]*) AirPlay="y"; break;
		;;
		[nN]*) AirPlay="n"; break;
		;;
		*) echo "Please enter a valid choice";
		;;
		esac
	done
fi
if [ -z "$SNAPCAST" ]
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
fi
if [ "$SNAPCAST" != "c" ]
then
	for _dep in ${SNAP_DEPS[@]}; do
    apt_install $_dep;
	done
    if [ -z "$SNAPNAME" ]
    then
    	read -p "SnapCast device name: " SNAPNAME
    fi
	sudo systemctl enable shairport-sync
	exc wget https://github.com/badaix/snapcast/releases/download/v0.12.0/snapserver_0.12.0_armhf.deb
	exc sudo dpkg -i snapserver_0.12.0_armhf.deb
	exc sudo apt-get -f install

	## Setup SnapServer
	save_original /etc/default/snapserver
	exc sudo sed -i "s/SNAPSERVER_OPTS=\"\"/#SNAPSERVER_OPTS=\"\"/" /etc/default/snapserver
	if [ "$AirPlay" = "y" ]
	then
		exc sudo sed -i "s+ExecStart=/usr/local/bin/shairport-sync.*+ExecStart=/usr/bin/sudo /usr/local/bin/shairport-sync -o pipe -- /tmp/snap_blue+" /lib/systemd/system/shairport-sync.service
		exc sudo usermod -aG sudo shairport-sync
		echo "shairport-sync ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/010_pi-nopasswd 
		sudo systemctl daemon-reload

	fi
		echo "SNAPSERVER_OPTS=\"-d -b 250 --sampleformat 44100:16:2 -s pipe:///tmp/snap_blue?name=$SNAPNAME&mode=read\"" | sudo tee -a /etc/default/snapserver			
	
    exc save_original /etc/pulse/system.pa
	echo "load-module module-pipe-sink file=/tmp/snap_blue sink_name=bluetooth" | sudo tee -a /etc/pulse/system.pa
	if [ -e "/usr/local/bin/bluez-udev" ]
	then
		exc sudo sed -i "s/audio_sink=0/audio_sink=1/" /usr/local/bin/bluez-udev
	fi
else
	for _dep in ${SNAP_DEPS[@]}; do
    apt_install $_dep;
	done
	while true
    do
        read -p "Enter SnapServer IP Address: " HOST_IP
        if [[ $HOST_IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
                break;
        else
                echo "Please enter valid IP Address"
        fi
	done
	
	read -p "Enter SnapClient name (i.e. Location it will be): " HOSTNAME
	
fi
### SOURCED FROM https://gist.github.com/totti2/41ed90feb1eb5838cc6a789d2b2dd5a7, thanks to totti2	
if [ "$SNAPCAST" = "c" ]
then
	#   DOWNLOAD, INSTALL AND CONFIGURE SNAPCLIENT
	exc wget https://github.com/badaix/snapcast/releases/download/v0.12.0/snapclient_0.12.0_armhf.deb
	exc sudo dpkg -i snapclient_0.12.0_armhf.deb

	exc save_original /etc/default/snapclient
	exc sudo sed -i "s/SNAPCLIENT_OPTS=\"\"/#SNAPCLIENT_OPTS=\"\"/" /etc/default/snapclient
	if [ "$SoundCard" = "0" ]
	then
		echo "SNAPCLIENT_OPTS=\"-h $HOST_IP -s 3 -d\"" | sudo tee -a /etc/default/snapclient
	else
		echo "SNAPCLIENT_OPTS=\"-h $HOST_IP -s 6 -d\"" | sudo tee -a /etc/default/snapclient
	fi
	sudo sed -i "s/raspberrypi/$HOSTNAME/" /etc/hosts		
	sudo sed -i "s/raspberrypi/$HOSTNAME/" /etc/hostname
elif [ "$SNAPCAST" = "b" ]
then
	#   DOWNLOAD, INSTALL AND CONFIGURE SNAPCLIENT
	exc wget https://github.com/badaix/snapcast/releases/download/v0.12.0/snapclient_0.12.0_armhf.deb
	exc sudo dpkg -i snapclient_0.12.0_armhf.deb

	exc save_original /etc/default/snapclient
	exc sudo sed -i "s/SNAPCLIENT_OPTS=\"\"/#SNAPCLIENT_OPTS=\"\"/" /etc/default/snapclient
	
	# Making a pretty rough guess here that this will work, likely will need to be changed by enduser,
	# snapclient --list or snapclient -l to see what the -s # should be.
	if [ "$SoundCard" = "0" ]
	then
		echo "SNAPCLIENT_OPTS=\"-h localhost -s 3 -d\"" | sudo tee -a /etc/default/snapclient
	else
		echo "SNAPCLIENT_OPTS=\"-h localhost -s 6 -d\"" | sudo tee -a /etc/default/snapclient
	fi
fi

## Removed Librespot Due to Exceedingly Long Install Time, it will be added as an option in future updates.
## Needs testing, and need to find a way for no user input
if [ -z "$LIBRESPOT" ]
then
	curl https://sh.rustup.rs -sSf | sh
	remove_dir librespot
	exc git clone https://github.com/plietar/librespot.git
	exc cd librespot
	$HOME/.cargo/bin/cargo build --release

	exc sudo cp target/release/librespot /usr/bin
	#whereis librespot
	#   CREATE SNAPCAST-STREAM = NEW PULSEAUDIO-SINK
	log "To Enable Librspot, use must use the following in /etc/default/snapserver : -s spotify:///librespot?name=SpotiPI&username=username&password=yourpassword&devicename=Spotify&bitrate=320"
	log "Or Use this as a walkthrough: https://gist.github.com/totti2/41ed90feb1eb5838cc6a789d2b2dd5a7"
fi
log SnapCast Install has Completed!
