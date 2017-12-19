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
SNAP_DIR=$currentDir/snapcast
exc remove_dir snapcast
exc git clone https://github.com/badaix/snapcast.git
exc cd $SNAP_DIR/externals
exc git submodule update --init --recursive
exc sudo apt-get install build-essential -y
exc sudo apt-get install libasound2-dev libvorbisidec-dev libvorbis-dev libflac-dev alsa-utils libavahi-client-dev avahi-daemon -y
exc cd $SNAP_DIR
exc make


if [ "$SNAPCAST" = "s" ]
then
    exc sudo make installserver
    echo "load-module module-pipe-sink file=/tmp/snapfifo sink_name=Snapcast" | sudo tee -a /etc/pulse/system.pa
    echo "set-default-sink Snapcast" | sudo tee -a /etc/pulse/system.pa
    exc sudo systemctl disable shairport-sync
    echo "sudo shairport-sync -a \"$SNAPNAME to Snapcast\" -o pipe -- /tmp/snapfifo&" >> ~/.profile
elif [ "$SNAPCAST" = "c" ]
then
    tst sudo make installclient
    echo "sudo snapclient &> /dev/null&" | sudo tee -a ~/.profile
    # Add set-default-sink-input here
elif [ "$SNAPCAST" = "b" ]
then
    exc sudo make installserver
    exc sudo make installclient
    echo "load-module module-pipe-sink file=/tmp/snapfifo sink_name=Snapcast" | sudo tee -a /etc/pulse/system.pa
    echo "set-default-sink Snapcast" | sudo tee -a /etc/pulse/system.pa
    echo "sudo snapclient &> /dev/null&" | sudo tee -a ~/.profile
    echo "sudo shairport-sync -a \"$SNAPNAME to Snapcast\" -o pipe -- /tmp/snapfifo&" >> ~/.profile

fi





