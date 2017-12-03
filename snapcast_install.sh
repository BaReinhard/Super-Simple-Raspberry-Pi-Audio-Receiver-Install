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

# Install docker
tst curl -sSL https://get.docker.com | sh
tst sudo apt-get update
tst sudo apt-get install apt-transport-https \
                       ca-certificates \
                       software-properties-common
tst curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
tst apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
tst echo "deb https://apt.dockerproject.org/repo/ raspbian-jessie main" >> /etc/apt/sources.list
tst sudo apt-get update
tst sudo apt-get -y install docker-engine
tst git clone https://github.com/nickaknudson/snapcast-pi.git ~/snapcast-pi && cd snapcast-pi
tst docker run -it -v $(pwd):/home/buildroot/snapcast-pi -w /home/buildroot/snapcast-pi nickaknudson/buildroot /bin/bash
BUILDROOT_VERSION=2016.11.2
tst git clone --branch $BUILDROOT_VERSION --depth=1 git://git.buildroot.net/buildroot ~/buildroot
tst git clone --depth=1 https://github.com/badaix/snapcast.git ~/snapcast


# if pi 0
tst make O=~/buildroot-output BR2_DL_DIR=~/buildroot-dl BR2_EXTERNAL=~/snapcast/buildroot:~/snapcast-pi/buildroot-external -C ~/buildroot snapcastpi0_defconfig


# if pi 3


tst make O=~/buildroot-output BR2_DL_DIR=~/buildroot-dl BR2_EXTERNAL=~/snapcast/buildroot:~/snapcast-pi/buildroot-external -C ~/buildroot menuconfig



### PICK FROM FLASHING
