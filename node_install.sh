#!/bin/bash

if [ -x "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi
exc wget https://nodejs.org/dist/v8.9.3/node-v8.9.3-linux-armv7l.tar.xz -P /tmp/
exc tar -xvf /tmp/node-v8.9.3-linux-armv7l.tar.xz --directory /tmp/
exc sudo mv /tmp/node-v8.9.3-linux-armv7l/bin/* /usr/sbin/

log Node has finished installing