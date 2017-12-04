#!/bin/bash
SNAP="SNAP"
while [ $SNAP != "s" ] && [ $SNAP != "c" ] && [ $SNAP != "b" ];
do
    read -p "Install this as a SnapCast Server(s), Client(c), and Both (b): (s/c/b)" SNAP
done
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
elif [ $SNAP = "c" ]
    tst sudo make installclient
elif [ $SNAP = "b" ]
    tst sudo make installserver
    tst sudo make installclient
fi
# LATER CREATE Config

# Change Pulse to output to snapcast

# Change Shairport to output to snapcast, shairport conf output /tmp/snapfifo

sudo cat << EOT >> /etc/pulse/system.pa
load-module module-pipe-sink file=/tmp/snapfifo sink_name=Snapcast 
EOT
