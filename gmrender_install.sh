#!/bin/bash
read -p "UPnP Device Name: " UPNP_NAME
#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi
}
#--------------------------------------------------------------------
# Install Dependencies
tst apt-get install libupnp-dev libgstreamer1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-alsa -y
# Download Package
tst git clone https://github.com/hzeller/gmrender-resurrect.git
tst cd gmrender-resurrect
# Setup Package
tst ./autogen.sh
tst ./configure
# Install Package
tst make
tst make install

# Add line to /etc/rc.local to allow for startup on boot
sed -i -e "\$i \/usr/local/bin/gmediarender -f $UPNP_NAME&\n" /etc/rc.local
