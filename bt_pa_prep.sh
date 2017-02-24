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


# Update
apt-get update -y

# Upgrade the distro
apt-get upgrade -y

echo "Done! You should reboot now"
