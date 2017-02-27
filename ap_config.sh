#!/bin/bash
read -p "Wifi Network name: " MYNAME
read -p "Wifi Password: " WIFIPASS
#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi	
}
#--------------------------------------------------------------------


# setup the config files
cp etc/network/interfaces /etc/network/interfaces
patch /etc/dhcpcd.conf <<EOT
@@ -39,3 +39,4 @@
 # A hook script is provided to lookup the hostname if not set by the DHCP
 # server, but it should not be run by default
 nohook lookup-hostname
+denyinterfaces wlan0
EOT
# Add patch for /etc/default/hostapd 
patch /etc/default/hostapd <<EOT
@@ -7,7 +7,7 @@
 # file and hostapd will be started during system boot. An example configuration
 # file can be found at /usr/share/doc/hostapd/examples/hostapd.conf.gz
 #
-#DAEMON_CONF=""
+DAEMON_CONF="/etc/hostapd/hostapd.conf"
 
 # Additional daemon options to be appended to hostapd command:-
 # 	-d   show more debug messages (-dd for even more)

EOT
patch /etc/init.d/hostapd <<EOT
@@ -16,7 +16,7 @@
 PATH=/sbin:/bin:/usr/sbin:/usr/bin
 DAEMON_SBIN=/usr/sbin/hostapd
 DAEMON_DEFS=/etc/default/hostapd
-DAEMON_CONF=
+DAEMON_CONF=/etc/hostapd/hostapd.conf
 NAME=hostapd
 DESC="advanced IEEE 802.11 management"
 PIDFILE=/run/hostapd.pid
EOT

# Setup AP
tst cp etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf

# Setup dhcp server

cat <<EOT >>/etc/dhcp/dhcpd.conf
ddns-update-style none;
ignore client-updates;
authoritative;
option local-wpad code 252 = text;
 
subnet
10.0.0.0 netmask 255.255.255.0 {
# --- default gateway
option routers
10.0.0.1;
# --- Netmask
option subnet-mask
255.255.255.0;
# --- Broadcast Address
option broadcast-address
10.0.0.255;
# --- Domain name servers, tells the clients which DNS servers to use.
option domain-name-servers
10.0.0.1, 8.8.8.8, 8.8.4.4;
option time-offset
0;
range 10.0.0.3 10.0.0.13;
default-lease-time 1209600;
max-lease-time 1814400;
}
EOT

# Add Patch for /etc/default/isc-dhcp-server
patch /etc/default/isc-dhcp-server <<EOT
@@ -18,4 +18,4 @@
 
 # On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
 #	Separate multiple interfaces with spaces, e.g. "eth0 eth1".
-INTERFACES=""
+INTERFACES="wlan0"
EOT

echo "You may now reboot your Pi"

