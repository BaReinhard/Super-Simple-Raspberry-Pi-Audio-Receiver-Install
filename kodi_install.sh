#!/bin/bash

if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi

# Install Dependenc
for _dep in ${KODI_DEPS[@]}; do
    apt_install $_dep;
done




