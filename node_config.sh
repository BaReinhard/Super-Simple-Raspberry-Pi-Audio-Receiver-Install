#!/bin/bash

if [ -z "$exc"]
then
    source functions.sh
    source dependencies.sh
fi

exc sudo cp -R node /usr/local/share/