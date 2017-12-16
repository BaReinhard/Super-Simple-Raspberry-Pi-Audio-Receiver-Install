#!/bin/bash

if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi
# Install Dependencies
for _dep in ${AP_DEPS[@]}; do
    apt_install $_dep;
done


