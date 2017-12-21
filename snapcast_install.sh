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

### SOURCED FROM https://gist.github.com/totti2/41ed90feb1eb5838cc6a789d2b2dd5a7, thanks to totti2
### Implemented soon!
#   DOWNLOAD, INSTALL SNAPCAST-SERVER AND CORRECT IT'S DEPENDENCIES
#wget https://github.com/badaix/snapcast/releases/download/v0.12.0/snapserver_0.12.0_armhf.deb
#sudo dpkg -i snapserver_0.12.0_armhf.deb
#sudo apt-get -f install

#   CREATE SNAPCAST-STREAM = NEW PULSEAUDIO-SINK
#sudo nano /etc/default/snapserver	
#   EDIT
#   #SNAPSERVER_OPTS=""
#   SNAPSERVER_OPTS="-d -b 250 --sampleformat 44100:16:2 -s pipe:///tmp/snap_blue?name=Bluetooth&mode=read"
#sudo reboot

#   CREATE SYSTEMWIDE PULSEAUDIO-PIPE-SINK
#sudo nano system.pa
#   APPEND
#   load-module module-pipe-sink file=/tmp/snap_blue sink_name=bluetooth
#sudo reboot

    ######## SINK-INPUT ASSIGMENTS JUMPS BACK TO SINK #0, COULD BE SOLVED BY DEACTIVATING ONBOARD-SOUND IN /boot/config.txt 
#    sudo pactl list sinks                                #   list pulseaudio sinks
#    sudo pactl list sink-inputs                          #   list pulseaudio sink-input
#    sudo pactl move-sink-input 0 1                       #   combine sink-input # with sink #
    ######## 

# ASSIGN SINK TO BLUETOOTH-DEVICE
# see https://github.com/BaReinhard/Super-Simple-Raspberry-Pi-Audio-Receiver-Install/issues/6#issuecomment-284573272
sudo nano /usr/local/bin/bluez-udev
# edit
# #audio_sink=0
# audio_sink=1
#sudo reboot
#   DOWNLOAD, INSTALL AND CONFIGURE SNAPCLIENT
#wget https://github.com/badaix/snapcast/releases/download/v0.12.0/snapclient_0.12.0_armhf.deb
#sudo dpkg -i snapclient_0.12.0_armhf.deb
#   LIST SOUNDCARDS
#snapclient --list
#   CONFIGURE SNAPCLIENT
#sudo nano /etc/default/snapclient
#   EDIT SNAPCLIENT_OPTS=""
#   -h <HOST> -s <SOUNDCARD> -d <DAEMONIZE>
#   SNAPCLIENT_OPTS="-h localhost -s 25 -d"
#sudo systemctl restart snapclient.service

# BUILD LIBRESPOT
#sudo apt-get install build-essential portaudio19-dev git
#curl https://sh.rustup.rs -sSf | sh
#git clone https://github.com/plietar/librespot.git
#sudo reboot
#cd librespot/
#cargo build --release
#$PATH
#sudo cp target/release/librespot /usr/bin
#whereis librespot
#   CREATE SNAPCAST-STREAM = NEW PULSEAUDIO-SINK

### NEEDS TESTING ###
#sed -i "s/SNAPSERVER_OPTS=/#SNAPSERVER_OPTS=/" /etc/default/snapserver
#echo "SNAPSERVER_OPTS="-d -b 250 --sampleformat 44100:16:2 -s pipe:///tmp/snap_blue?name=Bluetooth&mode=read -s spotify:///librespot?name=SpotiPI&username=username&password=yourpassword&devicename=Spotify&bitrate=320" | sudo tee -a /etc/default/snapserver
#sudo systemctl restart snapserver.service



## Need to remove after, above is sorted
SNAP_DIR=$currentDir/snapcast
exc remove_dir snapcast
exc git clone https://github.com/badaix/snapcast.git
exc cd $SNAP_DIR/externals
exc git submodule update --init --recursive
for _dep in ${SNAP_DEPS[@]}; do
    apt_install $_dep;
done
exc cd $SNAP_DIR
exc make


if [ "$SNAPCAST" = "s" ]
then
    exc sudo make installserver
    save_original /etc/pulse/system.pa
    echo "load-module module-pipe-sink file=/tmp/snapfifo sink_name=Snapcast" | sudo tee -a /etc/pulse/system.pa
    echo "set-default-sink Snapcast" | sudo tee -a /etc/pulse/system.pa
    exc sudo systemctl disable shairport-sync
    save_original $HOME/.profile
    echo "sudo shairport-sync -a \"$SNAPNAME to Snapcast\" -o pipe -- /tmp/snapfifo&" >> ~/.profile
elif [ "$SNAPCAST" = "c" ]
then
    exc sudo make installclient
    save_original $HOME/.profile
    echo "sudo snapclient &> /dev/null&" | sudo tee -a ~/.profile
    # Add set-default-sink-input here
elif [ "$SNAPCAST" = "b" ]
then
    exc sudo make installserver
    exc sudo make installclient
    save_original /etc/pulse/system.pa
    echo "load-module module-pipe-sink file=/tmp/snapfifo sink_name=Snapcast" | sudo tee -a /etc/pulse/system.pa
    echo "set-default-sink Snapcast" | sudo tee -a /etc/pulse/system.pa
    save_original $HOME/.profile
    echo "sudo snapclient &> /dev/null&" | sudo tee -a ~/.profile
    echo "sudo shairport-sync -a \"$SNAPNAME to Snapcast\" -o pipe -- /tmp/snapfifo&" >> ~/.profile
fi





