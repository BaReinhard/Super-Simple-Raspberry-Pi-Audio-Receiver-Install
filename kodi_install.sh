#!/bin/bash

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
tst apt-get install kodi -y
# Download TV-Addons Zip for easy installation
tst cd /home/kodi
tst wget http://fusion.tvaddons.ag/begin-here/plugin.program.indigo-1.0.2.zip

exit 0
