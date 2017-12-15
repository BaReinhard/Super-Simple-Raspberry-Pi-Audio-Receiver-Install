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
cat << EOT > /etc/default/hostapd 
# Defaults for hostapd initscript
#
# See /usr/share/doc/hostapd/README.Debian for information about alternative
# methods of managing hostapd.
#
# Uncomment and set DAEMON_CONF to the absolute path of a hostapd configuration
# file and hostapd will be started during system boot. An example configuration
# file can be found at /usr/share/doc/hostapd/examples/hostapd.conf.gz
#
DAEMON_CONF="/etc/hostapd/hostapd.conf"

# Additional daemon options to be appended to hostapd command:-
#       -d   show more debug messages (-dd for even more)
#       -K   include key data in debug messages
#       -t   include timestamps in some debug messages
#
# Note that -B (daemon mode) and -P (pidfile) options are automatically
# configured by the init.d script and must not be added to DAEMON_OPTS.
#
#DAEMON_OPTS=""




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
cat <<EOT > /etc/hostapd/hostapd.conf
interface=wlan0
driver=nl80211
ssid=$MYNAME
hw_mode=g
channel=6
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=$WIFIPASS
wpa_key_mgmt=WPA-PSK
#wpa_pairwise=TKIP      # You better do not use this weak encryption (only used by old client devices
rsn_pairwise=CCMP
ieee80211n=1          # 802.11n support
wmm_enabled=1         # QoS support
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
EOT

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

