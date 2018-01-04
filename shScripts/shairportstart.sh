#!/bin/sh
bluetoothctl << EOT
discoverable off
EOT
amixer cset numid=3 90%
exit 0
