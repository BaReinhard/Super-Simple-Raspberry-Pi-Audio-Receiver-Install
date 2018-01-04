#!/bin/bash

while true
do
RES=`inotifywait -q -e CREATE,DELETE /dev/input/`
case "$RES" in
"/dev/input/ DELETE event0")
ifconfig wlan0 up
;;
"/dev/input/ CREATE event0")
ifconfig wlan0 down
;;
esac
done &
