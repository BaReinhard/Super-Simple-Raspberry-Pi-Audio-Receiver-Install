#!/bin/bash


if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi

# Install Dependencies
for _dep in ${AIRPLAY_DEPS[@]}; do
    apt_install $_dep;
done

# Install shairplay-sync from source

exc cd ~
exc git clone https://github.com/mikebrady/shairport-sync.git
exc cd shairport-sync
exc autoreconf -i -f
exc ./configure --sysconfdir=/etc --with-stdout --with-pipe --with-alsa --with-avahi --with-ssl=openssl --with-metadata --with-soxr --with-systemd
exc make
exc getent group shairport-sync &>/dev/null || sudo groupadd -r shairport-sync >/dev/null
exc getent passwd shairport-sync &> /dev/null || sudo useradd -r -M -g shairport-sync -s /usr/bin/nologin -G audio shairport-sync >/dev/null
exc make install
exc systemctl enable shairport-sync
