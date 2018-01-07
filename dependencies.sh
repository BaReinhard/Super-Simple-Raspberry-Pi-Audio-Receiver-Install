#!/bin/bash

BT_DEPS="pulseaudio-module-bluetooth python-dbus libltdl-dev pulseaudio libtool intltool libsndfile-dev libcap-dev libasound2-dev libavahi-client-dev libbluetooth-dev libglib2.0-dev libsamplerate0-dev libsbc-dev libspeexdsp-dev libssl-dev libtdb-dev libbluetooth-dev intltool autoconf autogen automake build-essential libasound2-dev libflac-dev libogg-dev libtool libvorbis-dev pkg-config python"

JESSIE_BT_DEPS="libjson0-dev"

STRETCH_BT_DEPS="libjson-c-dev autopoint"

VOLUMIO_DEPS="bluez bluez-firmware libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev libltdl-dev libsamplerate0-dev libsndfile1-dev libasound2-dev libavahi-client-dev libspeexdsp-dev liborc-0.4-dev intltool libtdb-dev libssl-dev libjson0-dev libsbc-dev libcap-dev"

AP_DEPS="hostapd isc-dhcp-server"

AIRPLAY_DEPS="build-essential git autoconf automake libtool libdaemon-dev libasound2-dev libpopt-dev libconfig-dev avahi-daemon libavahi-client-dev libssl-dev libpolarssl-dev libsoxr-dev"

KODI_DEPS="kodi"

GMEDIA_DEPS="libupnp-dev libgstreamer1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-alsa"

LIRC_DEPS="lirc"

SNAP_DEPS="build-essential portaudio19-dev git libasound2-dev libvorbisidec-dev libvorbis-dev libflac-dev alsa-utils libavahi-client-dev avahi-daemon"

INSTALL_COMMAND="sudo apt-get install -y"

SSPARI_FILES="/usr/local/bin/bluez-udev /usr/local/bin/simple-agent.autotrust /usr/local/bin/shairportstart.sh /usr/local/bin/shairportend.sh /usr/local/bin/bluezutils.py /usr/local/bin/firstrun.sh /usr/local/bin/say.sh /usr/local/bin/updatewifi /usr/local/bin/volume-watcher.py \
/etc/init.d/bluetooth /etc/init.d/pulseaudio /etc/init.d/bluetooth-agent /lib/systemd/system/volume-watcher.service"
