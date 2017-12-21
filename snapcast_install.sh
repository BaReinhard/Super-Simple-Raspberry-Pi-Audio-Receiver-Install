#!/bin/bash
if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi
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
    if [ -z "$SNAPNAME" ]
    then
    	read -p "SnapCast device name: " SNAPNAME
    fi
    
fi
if [ $SUDO_USER ]; then user=$SUDO_USER ; else user=`whoami`; fi

currentDir=$(
  cd $(dirname "$0")
  pwd
) 


for _dep in ${SNAP_DEPS[@]}; do
    apt_install $_dep;
done

### SOURCED FROM https://gist.github.com/totti2/41ed90feb1eb5838cc6a789d2b2dd5a7, thanks to totti2
if [ "$SNAPCAST" = "s" ]
then
	sudo systemctl disable shairport-sync
	exc wget https://github.com/badaix/snapcast/releases/download/v0.12.0/snapserver_0.12.0_armhf.deb
	exc sudo dpkg -i snapserver_0.12.0_armhf.deb
	exc sudo apt-get -f install

	## Setup SnapServer
	save_original /etc/default/snapserver
	exc sudo sed -i "s/SNAPSERVER_OPTS=\"\"/#SNAPSERVER_OPTS=\"\"/" /etc/default/snapserver
	if [ "$AirPlay" = "y" ]
	then
		echo "SNAPSERVER_OPTS=\"-d -b 250 --sampleformat 44100:16:2 -s pipe:///tmp/snap_blue?name=$SNAPNAME&mode=read -s airplay:///shairport-sync?name=$SNAPNAME&devicename=Snapcast&port=5000\"" | sudo tee -a /etc/default/snapserver	
	else
		echo "SNAPSERVER_OPTS=\"-d -b 250 --sampleformat 44100:16:2 -s pipe:///tmp/snap_blue?name=$SNAPNAME&mode=read\"" | sudo tee -a /etc/default/snapserver			
	fi
	#echo "SNAPSERVER_OPTS=\"-d -b 250 --sampleformat 44100:16:2 -s pipe:///tmp/snap_blue?name=Bluetooth&mode=read\"" | sudo tee -a /etc/default/snapserver

	exc save_original /etc/pulse/system.pa
	echo "load-module module-pipe-sink file=/tmp/snap_blue sink_name=bluetooth" | sudo tee -a /etc/pulse/system.pa
	
	exc sudo sed -i "s/audio_sink=0/audio_sink=1/" /usr/local/bin/bluez-udev
elif [ "$SNAPCAST" = "c" ]
then
	#   DOWNLOAD, INSTALL AND CONFIGURE SNAPCLIENT
	exc wget https://github.com/badaix/snapcast/releases/download/v0.12.0/snapclient_0.12.0_armhf.deb
	exc sudo dpkg -i snapclient_0.12.0_armhf.deb

	exc save_original /etc/default/snapclient
	exc sudo sed -i "s/SNAPCLIENT_OPTS=\"\"/#SNAPCLIENT_OPTS=\"\"/" /etc/default/snapclient
	echo "SNAPCLIENT_OPTS=\"-h localhost -s 3 -d\"" | sudo tee -a /etc/default/snapclient
elif [ "$SNAPCAST" = "b" ]
then
	exc sudo systemctl disable shairport-sync
	exc wget https://github.com/badaix/snapcast/releases/download/v0.12.0/snapserver_0.12.0_armhf.deb
	exc sudo dpkg -i snapserver_0.12.0_armhf.deb
	exc sudo apt-get -f install

	## Setup SnapServer
	exc save_original /etc/default/snapserver
	exc sudo sed -i "s/SNAPSERVER_OPTS=\"\"/#SNAPSERVER_OPTS=\"\"/" /etc/default/snapserver
	if [ "$AirPlay" = "y" ]
	then
		echo "SNAPSERVER_OPTS=\"-d -b 250 --sampleformat 44100:16:2 -s pipe:///tmp/snap_blue?name=$SNAPNAME&mode=read -s airplay:///shairport-sync?name=$SNAPNAME&devicename=Snapcast&port=5000\"" | sudo tee -a /etc/default/snapserver	
	else
		echo "SNAPSERVER_OPTS=\"-d -b 250 --sampleformat 44100:16:2 -s pipe:///tmp/snap_blue?name=$SNAPNAME&mode=read\"" | sudo tee -a /etc/default/snapserver			
	fi

	#echo "SNAPSERVER_OPTS=\"-d -b 250 --sampleformat 44100:16:2 -s pipe:///tmp/snap_blue?name=Bluetooth&mode=read\"" | sudo tee -a /etc/default/snapserver

	excsave_original /etc/pulse/system.pa
	echo "load-module module-pipe-sink file=/tmp/snap_blue sink_name=bluetooth" | sudo tee -a /etc/pulse/system.pa
	
	exc sudo sed -i "s/audio_sink=0/audio_sink=1/" /usr/local/bin/bluez-udev
	#   DOWNLOAD, INSTALL AND CONFIGURE SNAPCLIENT
	exc wget https://github.com/badaix/snapcast/releases/download/v0.12.0/snapclient_0.12.0_armhf.deb
	exc sudo dpkg -i snapclient_0.12.0_armhf.deb

	exc save_original /etc/default/snapclient
	exc sudo sed -i "s/SNAPCLIENT_OPTS=\"\"/#SNAPCLIENT_OPTS=\"\"/" /etc/default/snapclient
	echo "SNAPCLIENT_OPTS=\"-h localhost -s 3 -d\"" | sudo tee -a /etc/default/snapclient
fi

## Removed Librespot Due to Exceedingly Long Install Time, it will be added as an option in future updates.
#curl https://sh.rustup.rs -sSf | sh
#remove_dir librespot
#exc git clone https://github.com/plietar/librespot.git
#exc cd librespot
#$HOME/.cargo/bin/cargo build --release

#exc sudo cp target/release/librespot /usr/bin
#whereis librespot
#   CREATE SNAPCAST-STREAM = NEW PULSEAUDIO-SINK
log SnapCast Install has Completed!