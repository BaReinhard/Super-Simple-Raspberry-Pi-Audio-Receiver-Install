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

tst aptitude install libupnp-dev libgstreamer1.0-dev \
             gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
             gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
             gstreamer1.0-libav gstreamer1.0-alsa
tst git clone https://github.com/hzeller/gmrender-resurrect.git
tst cd gmrender-resurrect
tst ./autogen.sh
tst ./configure
tst make
tst make install

# Add line to /etc/rc.local to allow for startup on boot
tst sed -i -e "\$i \/usr/local/bin/gmediarenderer -f $UPNP_NAME&\n" /etc/rc.local
