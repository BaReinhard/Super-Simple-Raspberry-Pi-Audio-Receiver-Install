#!/bin/bash
if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
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
wget https://github.com/badaix/snapcast/releases/download/v0.12.0/snapserver_0.12.0_armhf.deb
sudo dpkg -i snapserver_0.12.0_armhf.deb
sudo apt-get -f install

## Setup SnapServer
save_original /etc/default/snapserver
sudo sed -i "s/SNAPSERVER_OPTS=\"\"/#SNAPSERVER_OPTS=\"\"/" /etc/default/snapserver
#echo "SNAPSERVER_OPTS=\"-d -b 250 --sampleformat 44100:16:2 -s pipe:///tmp/snap_blue?name=Bluetooth&mode=read\"" | sudo tee -a /etc/default/snapserver

save_original /etc/pulse/system.pa
echo "load-module module-pipe-sink file=/tmp/snap_blue sink_name=bluetooth" | sudo tee -a /etc/pulse/system.pa

sudo sed -i "s/audio_sink=0/audio_sink=1/" /usr/local/bin/bluez-udev

#   DOWNLOAD, INSTALL AND CONFIGURE SNAPCLIENT
wget https://github.com/badaix/snapcast/releases/download/v0.12.0/snapclient_0.12.0_armhf.deb
exc sudo dpkg -i snapclient_0.12.0_armhf.deb

save_original /etc/default/snapclient
sudo sed -i "s/SNAPCLIENT_OPTS=\"\"/#SNAPCLIENT_OPTS=\"\"/" /etc/default/snapclient
echo "SNAPCLIENT_OPTS=\"-h localhost -s 3 -d\"" | sudo tee -a /etc/default/snapclient


## Removed Librespot Due to Exceedingly Long Install Time, it will be added as an option in future updates.
#curl https://sh.rustup.rs -sSf | sh
#remove_dir librespot
#exc git clone https://github.com/plietar/librespot.git
#exc cd librespot
#$HOME/.cargo/bin/cargo build --release

#exc sudo cp target/release/librespot /usr/bin
#whereis librespot
#   CREATE SNAPCAST-STREAM = NEW PULSEAUDIO-SINK

### NEEDS TESTING ###
#sed -i "s/SNAPSERVER_OPTS=/#SNAPSERVER_OPTS=/" /etc/default/snapserver
echo "SNAPSERVER_OPTS=\"-d -b 250 --sampleformat 44100:16:2 -s pipe:///tmp/snap_blue?name=$SNAPNAME&mode=read -s -s airplay:///shairport-sync?name=$SNAPNAME&devicename=Snapcast&port=5000" | sudo tee -a /etc/default/snapserver



#exc cd $SNAP_DIR
#exc make


#if [ "$SNAPCAST" = "s" ]
#then
#    exc sudo make installserver
#    save_original /etc/pulse/system.pa
#    echo "load-module module-pipe-sink file=/tmp/snapfifo sink_name=Snapcast" | sudo tee -a /etc/pulse/system.pa
#    echo "set-default-sink Snapcast" | sudo tee -a /etc/pulse/system.pa
#    exc sudo systemctl disable shairport-sync
#    save_original $HOME/.profile
#    echo "sudo shairport-sync -a \"$SNAPNAME to Snapcast\" -o pipe -- /tmp/snapfifo&" >> ~/.profile
#elif [ "$SNAPCAST" = "c" ]
#then
#    exc sudo make installclient
#    save_original $HOME/.profile
#    echo "sudo snapclient &> /dev/null&" | sudo tee -a ~/.profile
#    # Add set-default-sink-input here
#elif [ "$SNAPCAST" = "b" ]
#then
#    exc sudo make installserver
#    exc sudo make installclient
#    save_original /etc/pulse/system.pa
#    echo "load-module module-pipe-sink file=/tmp/snapfifo sink_name=Snapcast" | sudo tee -a /etc/pulse/system.pa
#    echo "set-default-sink Snapcast" | sudo tee -a /etc/pulse/system.pa
#    save_original $HOME/.profile
#    echo "sudo snapclient &> /dev/null&" | sudo tee -a ~/.profile
#    echo "sudo shairport-sync -a \"$SNAPNAME to Snapcast\" -o pipe -- /tmp/snapfifo&" >> ~/.profile
#fi





