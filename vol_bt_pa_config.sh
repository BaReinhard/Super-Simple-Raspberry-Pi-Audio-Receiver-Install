#!/bin/bash

if [ -z "$BluetoothName" ]
then
 read -p "Bluetooth device name: " BluetoothName
fi
if [ -z "$exc" ]
then 
    source functions.sh
    source dependencies.sh
fi