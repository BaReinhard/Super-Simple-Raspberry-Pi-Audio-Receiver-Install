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
cat << EOT >>/boot/config.txt
# Enabled Lirc
dtoverlay=lirc-rpi
dtparam=gpio_in_pin=24
dtparam=gpio_out_pin=17

EOT
cat << EOT > /etc/lirc/lircd.conf

# Please make this file available to others
# by sending it to <lirc@bartelmus.de>
#
# this config file was automatically generated
# using lirc-0.9.0-pre1(default) on Sun Feb 19 19:57:44 2017
#
# contributed by 
#
# brand:                       lircd.conf.conf
# model no. of remote control: 
# devices being controlled by this remote:
#

begin remote

  name  matricom
  bits           16
  flags SPACE_ENC|CONST_LENGTH
  eps            30
  aeps          100

  header       9064  4449
  one           623  1616
  zero          623   490
  ptrail        623
  repeat       9067  2200
  pre_data_bits   16
  pre_data       0x807F
  gap          111930
  toggle_bit_mask 0x0

      begin codes
          KEY_UP                   0x6897
          KEY_DOWN                 0x58A7
          KEY_LEFT                 0x8A75
          KEY_RIGHT                0x0AF5
          KEY_STOP                 0x02FD
          KEY_PLAYPAUSE            0xB24D
          KEY_MUTE                 0x827D
          KEY_VOLUMEUP             0x8877
          KEY_VOLUMEDOWN           0x32CD
          KEY_MENU                 0x08F7
          KEY_HOME                 0x18E7
          KEY_BACK                 0x9867
          KEY_1                    0x728D
          KEY_2                    0xB04F
          KEY_3                    0x30CF
          KEY_4                    0x52AD
          KEY_5                    0x906F
          KEY_6                    0x10EF
          KEY_7                    0x629D
          KEY_8                    0xA05F
          KEY_9                    0x20DF
          KEY_EXIT                 0x42BD
          KEY_0                    0x807F
          BTN_TOOL_MOUSE           0x00FF
  	  KEY_OK                0x807FC837

      end codes

end remote
EOT
cat << EOT > /etc/lirc/hardware.conf
# /etc/lirc/hardware.conf
#
# Arguments which will be used when launching lircd
LIRCD_ARGS=""

#Don't start lircmd even if there seems to be a good config file
#START_LIRCMD=false

#Don't start irexec, even if a good config file seems to exist.
#START_IREXEC=false

#Try to load appropriate kernel modules
LOAD_MODULES=true

# Run "lircd --driver=help" for a list of supported drivers.
DRIVER=""
# usually /dev/lirc0 is the correct setting for systems using udev 
DEVICE="/dev/lirc0"
MODULES=""

# Default configuration files for your hardware if any
LIRCD_CONF="/etc/lirc/lircd.conf"
LIRCMD_CONF=""
EOT

cat << EOT > /home/pi/Lircmap.xml
<?xml version="1.0" encoding="UTF-8"?>
<!-- This file contains the mapping of LIRC keys to XBMC keys used in Keymap.xml  -->
<!--                                                                              -->
<!-- How to add remotes                                                           -->
<!-- <remote device="name_Lirc_calls_the_remote">                                 -->
<!--                                                                              -->
<!-- For the commands the layout following layout is used                         -->
<!-- <XBMC_COMMAND>LircButtonName</XBMC_COMMAND>                                  -->
<!--                                                                              -->
<!-- For a list of XBMC_COMMAND's check out the <remote> sections of keymap.xml   -->

<lircmap>
	<remote device="matricom">
		<left>KEY_LEFT</left>
		<right>KEY_RIGHT</right>
		<up>KEY_UP</up>
		<down>KEY_DOWN</down>
		<select>KEY_OK</select>
		<enter>KEY_ENTER</enter>
		<clear>KEY_DELETE</clear>
		<start>KEY_MEDIA</start>
		<back>KEY_BACK</back>
		<record>KEY_RECORD</record>
		<playpause>KEY_PLAYPAUSE</playpause>
		<stop>KEY_STOP</stop>
		<forward>KEY_FASTFORWARD</forward>
		<reverse>KEY_REWIND</reverse>
		<volumeplus>KEY_VOLUMEUP</volumeplus>
		<volumeminus>KEY_VOLUMEDOWN</volumeminus>
		<channelplus>KEY_CHANNELUP</channelplus>
		<channelminus>KEY_CHANNELDOWN</channelminus>
		<skipplus>KEY_NEXT</skipplus>
		<skipminus>KEY_PREVIOUS</skipminus>
		<title>KEY_EPG</title>
		<subtitle>KEY_SUBTITLE</subtitle>
		<language>KEY_LANGUAGE</language>
		<info>KEY_INFO</info>
		<display>KEY_ZOOM</display>
		<mute>KEY_MUTE</mute>
		<power>KEY_POWER</power>
		<eject>KEY_EJECTCD</eject>
		<eject>KEY_EJECTCLOSECD</eject>
		<menu>KEY_DVD</menu>
		<menu>KEY_MENU</menu>
		<myvideo>KEY_VIDEO</myvideo>
		<mymusic>KEY_AUDIO</mymusic>
		<mypictures>KEY_CAMERA</mypictures>
		<mytv>KEY_TUNER</mytv>
		<mytv>KEY_TV</mytv>
		<teletext>KEY_TEXT</teletext>
		<one>KEY_NUMERIC_1</one>
		<two>KEY_NUMERIC_2</two>
		<three>KEY_NUMERIC_3</three>
		<four>KEY_NUMERIC_4</four>
		<five>KEY_NUMERIC_5</five>
		<six>KEY_NUMERIC_6</six>
		<seven>KEY_NUMERIC_7</seven>
		<eight>KEY_NUMERIC_8</eight>
		<nine>KEY_NUMERIC_9</nine>
		<zero>KEY_NUMERIC_0</zero>
		<star>KEY_NUMERIC_STAR</star>
		<hash>KEY_NUMERIC_POUND</hash>
		<red>KEY_RED</red>
		<green>KEY_GREEN</green>
		<yellow>KEY_YELLOW</yellow>
		<blue>KEY_BLUE</blue>
		<recordedtv>KEY_PVR</recordedtv> 
		<liveradio>KEY_RADIO</liveradio> 
	</remote>
</lircmap>
EOT
cat <<EOT >/etc/rc.local
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Print the IP address
_IP=$(hostname -I) || true
if [ "$_IP" ]; then
  printf "My IP address is %s\n" "$_IP"
fi

/home/pi/shScripts/firstrun.sh&
exit 0
EOT
chmod +x /etc/rc.local
cat <<EOT >/home/pi/shScripts/firstrun.sh
#!/bin/bash
cp /home/pi/Lircmap.xml /home/kodi/.kodi/userdata/Lircmap.xml
rm /home/pi/shScripts/firstrun.sh
touch /home/pi/shScripts/firstrun.sh
echo "#!/bin/bash" >> /home/pi/shScripts/firstrun.sh
echo "exit 0" >> /home/pishScripts/firstrun.sh
reboot
EOT
chmod +x /home/pi/shScripts/firstrun.sh

exit 0
