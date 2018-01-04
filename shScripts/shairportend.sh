#!/bin/sh
bluetoothctl << EOT
discoverable on
EOT
amixer cset numid=3 90%
exit 0
