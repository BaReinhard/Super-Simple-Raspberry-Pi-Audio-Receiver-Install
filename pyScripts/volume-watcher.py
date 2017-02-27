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
