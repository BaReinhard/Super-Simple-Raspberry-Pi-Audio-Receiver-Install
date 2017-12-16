#!/bin/bash
SNAP="SNAP"
SnapName=SNAPCAST
while [ $SNAP != "s" ] && [ $SNAP != "c" ] && [ $SNAP != "b" ];
do
    read -p "Install this as a SnapCast Server(s), Client(c), and Both (b): (s/c/b)" SNAP
done

read -p "SnapCast device name: " SnapName
if [ $SUDO_USER ]; then user=$SUDO_USER ; else user=`whoami`; fi
#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi
}
#--------------------------------------------------------------------
PWD=`pwd`
SNAP_DIR=$PWD/snapcast
tst git clone https://github.com/badaix/snapcast.git
tst cd $SNAP_DIR/externals
tst git submodule update --init --recursive
tst sudo apt-get install build-essential -y
tst sudo apt-get install libasound2-dev libvorbisidec-dev libvorbis-dev libflac-dev alsa-utils libavahi-client-dev avahi-daemon -y
tst cd $SNAP_DIR
tst make


if [ $SNAP = "s" ]
then
    tst sudo make installserver
    echo "load-module module-pipe-sink file=/tmp/snapfifo sink_name=Snapcast" | sudo tee -a /etc/pulse/system.pa
    echo "set-default-sink Snapcast" | sudo tee -a /etc/pulse/system.pa
    sudo systemctl disable shairport-sync
    echo "sudo shairport-sync shairport-sync -a \"$SnapName to Snapcast\" -o pipe -- /tmp/snapfifo" >> ~/.profile
elif [ $SNAP = "c" ]
then
    tst sudo make installclient
    echo "sudo snapclient" | sudo tee -a ~/.profile
    # Add set-default-sink-input here
elif [ $SNAP = "b" ]
then
    tst sudo make installserver
    tst sudo make installclient
    echo "load-module module-pipe-sink file=/tmp/snapfifo sink_name=Snapcast" | sudo tee -a /etc/pulse/system.pa
    echo "set-default-sink Snapcast" | sudo tee -a /etc/pulse/system.pa
    echo "sudo snapclient" | sudo tee -a ~/.profile
fi


echo "Snapcast Install Has Finished"




