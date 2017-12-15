#!/bin/bash

source functions.sh
source dependencies.sh


# Update

apt_update apt-get update -q=2 -y

# Upgrade the distro
apt_upgrade apt-get upgrade -q=2 -y


for _dep in ${BT_DEPS[@]}; do
    apt_install $_dep;
done

echo "Done! You should reboot now"
