#!/bin/bash

#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi	
}
#--------------------------------------------------------------------


# Install Dependencies
tst apt-get install kodi -y
patch /etc/default/kodi << EOT
@@ -1,5 +1,5 @@
 # Set this to 1 to enable startup
-ENABLED=0
+ENABLED=1
 
 # The user to run Kodi as
 USER=kodi

EOT

usermod -a -G input kodi
echo gpu_mem=256 >> /boot/config.txt

cd /home/kodi
wget http://fusion.tvaddons.ag/begin-here/plugin.program.indigo-1.0.2.zip

exit 0
