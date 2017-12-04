#!/bin/bash
if [ $SUDO_USER ]; then echo "needs to be run as non-root user";exit 1; else user=`whoami`; fi
#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi
}
#--------------------------------------------------------------------
SNAP_DIR=/home/${user}/snapcast
tst git clone https://github.com/badaix/snapcast.git
tst cd $SNAP_DIR/externals
tst git submodule update --init --recursive
tst sudo apt-get install build-essential -y
tst sudo apt-get install libasound2-dev libvorbisidec-dev libvorbis-dev libflac-dev alsa-utils libavahi-client-dev avahi-daemon -y
tst cd $SNAP_DIR
tst make

# IF CLIENT OR SERVER IMPLEMENT LATER
tst sudo make installserver
tst sudo make installclient

# LATER CREATE Config

# Change Pulse to output to snapcast

# Change Shairport to output to snapcast, shairport conf output /tmp/snapfifo
