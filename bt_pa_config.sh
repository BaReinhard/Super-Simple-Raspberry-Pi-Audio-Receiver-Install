#!/bin/bash

#The bluetooth device can appear as a number of things.
#Change the line '+ Class = 0x200414' below to one of the following classes;
# 0x200418 - Headphones
# 0x200414 - Loudspeaker (default)
# 0x200420 - Car Audio
# 0x200434 - Car audio, Loudspeaker
# 0x200438 - Car Audio, Headphones
#
# All of the above classes show the headphone icon on iOS when connected.
# If you wish to not have that icon then use one of the following;
# 0x20041C - Headphones, Portable Audio / Portable Audio
# 0x20043C - Headphones, Portable Audio, Car audio / Portable Audio, Car audio


read -p "Bluetooth device name: " BT_NAME

#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi	
}
#--------------------------------------------------------------------

tst cd `dirname $0`

sudo echo "PRETTY_HOSTNAME=$BT_NAME" >> /tmp/machine-info
tst sudo cp /tmp/machine-info /etc

tst sudo cp init.d/pulseaudio /etc/init.d
tst sudo chmod +x /etc/init.d/pulseaudio
tst sudo update-rc.d pulseaudio defaults

tst sudo cp init.d/bluetooth /etc/init.d
tst sudo chmod +x /etc/init.d/bluetooth
tst sudo update-rc.d bluetooth defaults

tst sudo cp init.d/bluetooth-agent /etc/init.d
tst sudo chmod +x /etc/init.d/bluetooth-agent
tst sudo update-rc.d bluetooth-agent defaults

tst sudo cp usr_local_bin/bluez-udev /usr/local/bin
tst sudo chmod 755 /usr/local/bin/bluez-udev

tst sudo cp usr_local_bin/simple-agent.autotrust /usr/local/bin
tst sudo chmod 755 /usr/local/bin/simple-agent.autotrust

tst sudo cp usr_local_bin/say.sh /usr/local/bin
tst sudo chmod 755 /usr/local/bin/say.sh

tst sudo cp usr_local_bin/bluezutils.py /usr/local/bin

tst sudo cp misc_setup/daemon.conf /etc/pulse

sudo patch /boot/config.txt << EOT
@@ -54,3 +54,6 @@
 
 # Enable audio (loads snd_bcm2835)
 dtparam=audio=on
+
+# High Quality audio patch
+audio_pwm_mode=2
EOT

if [ -f /etc/udev/rules.d/99-com.rules ]; then

sudo patch /etc/udev/rules.d/99-com.rules << EOT
***************
*** 1 ****
--- 1,2 ----
  SUBSYSTEM=="input", GROUP="input", MODE="0660"
+ KERNEL=="input[0-9]*", RUN+="/usr/local/bin/bluez-udev"
EOT

else

tst sudo touch /etc/udev/rules.d/99-com.rules
tst sudo chmod 666 /etc/udev/rules.d/99-com.rules
sudo cat  << EOT > /etc/udev/rules.d/99-input.rules
SUBSYSTEM=="input", GROUP="input", MODE="0660"
KERNEL=="input[0-9]*", RUN+="/usr/local/bin/bluez-udev"
EOT

fi

tst sudo chmod 644 /etc/udev/rules.d/99-com.rules

sudo patch /etc/bluetooth/main.conf << EOT
***************
*** 7,8 ****
--- 7,9 ----
  #Name = %h-%d
+ Name = ${BT_NAME}

***************
*** 11,12 ****
--- 12,14 ----
  #Class = 0x000100
+ Class = 0x200414

***************
*** 15,17 ****
  # 0 = disable timer, i.e. stay discoverable forever
! #DiscoverableTimeout = 0

--- 17,19 ----
  # 0 = disable timer, i.e. stay discoverable forever
! DiscoverableTimeout = 0
EOT

sudo patch /etc/pulse/system.pa << EOT
***************
*** 23,25 ****
  .ifexists module-udev-detect.so
! load-module module-udev-detect
  .else
--- 23,26 ----
  .ifexists module-udev-detect.so
! #load-module module-udev-detect
! load-module module-udev-detect tsched=0
  .else
***************
*** 57 ****
--- 58,63 ----
  load-module module-position-event-sounds
+
+ ### Automatically load driver modules for Bluetooth hardware
+ .ifexists module-bluetooth-discover.so
+     load-module module-bluetooth-discover
+ .endif
EOT


#sudo service bluetooth start &
#sudo service pulseaudio start &
#sudo service bluetooth-agent start &
cd /home/pi
mkdir pyScripts
cd pyScripts
cat <<EOT > volume-watcher.py
#!/usr/bin/python

import os
import sys
import signal
import logging
import logging.handlers
import dbus
import dbus.service
import dbus.mainloop.glib
try:
    import gobject
except ImportError:
    from gi.repository import GObject as gobject

LOG_LEVEL = logging.INFO
#LOG_LEVEL = logging.DEBUG
LOG_FILE = "/dev/log"
LOG_FORMAT = "%(asctime)s %(levelname)s %(message)s"
BLUEZ_DEV = "org.bluez.MediaTransport1"

def device_property_changed_cb(property_name, value, path, interface, device_path):
	global bus
	if property_name != BLUEZ_DEV:
		return

	device = dbus.Interface(bus.get_object("org.bluez", device_path), "org.freedesktop.DBus.Properties")
	properties = device.GetAll(BLUEZ_DEV)

	logger.info("Getting dbus interface for device: %s interface: %s property_name: %s" % (device_path, interface, property_name))

	vol = properties["Volume"]
	volume_percentage = format(vol / 1.27, '.2f')
	logger.info("Detected volume change: {} ({})".format(vol, volume_percentage) )
	cmd = "amixer cset numid=3 {}%".format(volume_percentage)
	logger.info("Running cmd: {}".format(cmd))
	os.system(cmd)

def shutdown(signum, frame):
	mainloop.quit()

if __name__ == "__main__":
	# shut down on a TERM signal
	signal.signal(signal.SIGTERM, shutdown)

	# start logging
	logger = logging.getLogger("volume-watcher")
	logger.setLevel(LOG_LEVEL)
	logger.addHandler(logging.handlers.SysLogHandler(address = "/dev/log"))
	logger.info("Starting to monitor for AVRCP Volume changes")

	# Get the system bus
	try:
		dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
		bus = dbus.SystemBus()
	except Exception as ex:
		logger.error("Unable to get the system dbus: '{0}'. Exiting. Is dbus running?".format(ex.message))
		sys.exit(1)

	# listen for signals on the Bluez bus
	bus.add_signal_receiver(device_property_changed_cb, bus_name="org.bluez", signal_name="PropertiesChanged", path_keyword="device_path", interface_keyword="interface")

	try:
		mainloop = gobject.MainLoop()
		mainloop.run()
	except KeyboardInterrupt:
		pass
	except:
		logger.error("Unable to run the gobject main loop")
		sys.exit(1)

	logger.info("Shutting down")
	sys.exit(0)
EOT
chmod +x *
cd /lib/systemd/system/
cat << 'EOT' > volume-watcher.service
[Unit]
Description=Watches Bluetooth for Volume Change
After=multi-user.target

[Service]
ExecStart=/usr/bin/python /home/pi/pyScripts/volume-watcher.py
ExecStop=/bin/kill -9 $MAINPID
StandardOutput=null

[Install]
WantedBy=multi-user.target
Alias=volume-watcher.service
EOT
systemctl enable volume-watcher
sleep 5

echo "Done! You should reboot now"
