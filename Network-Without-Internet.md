
# Raspberry Pi Network Without Internet

This project was created with Teachers in mind. The project allows for a Raspberry Pi to be setup as a Wireless Access Point. It allows for a network to be created without access to the internet (internet can be added). This will allow multiple users (or one per pi) to ssh to the pi and have the user to play around with the GNU/Debian OS. This project is well suited for use in a school setting where teachers want the kids to be able to connect to a Raspberry Pi, but the administration (for whatever reason) does not want a Raspberry Pi (or multiple users) active on their network.

* Raspberry Pi Zero or any Raspberry Pi before 3 will need a WiFi card to use the new Access Point feature, some cards are not compatible with hostapd right out of the box and may require a forked repo of hostapd. If you are using a tp-link usb adapter you can follow the guide here to fix how the current install feature has set this up.GUIDE: [Pi Zero hostapd Fix](https://bareinhard.github.io/2017/02/15/Fix-hostapd-Raspberry-Pi-Zero.html)

## Install
#### This will install on the latest Raspbian Jessie, with just the following commands.

```
pi@raspberrypi:~/ $ sudo apt-get install git
pi@raspberrypi:~/ $ git clone https://github.com/BaReinhard/Super-Simple-Raspberry-Pi-Audio-Receiver-Install.git
pi@raspberrypi:~/ $ cd Super-Simple-Raspberry-Pi-Audio-Receiver-Install
pi@raspberrypi:~/Super-Simple-Raspberry-Pi-Audio-Receiver-Install $ sudo ./install.sh
1. Install the Raspberry Pi Audio Receiver Car Installation
2. Install the Raspberry Pi Audio Receiver Home Installation
3. Install the Raspberry Pi Network Without Internet Installation (For teaching!)"
4. Install a Custom Raspberry Pi Audio Receiver
Which installation would you like to choose? (1/2/3/4) : Choose 1, 2, 3, or 4
Do you want all the Devices to use the same name? (y/n) : Choose y or n

# When Choosing 'y'
Device name: Choose Device Name
Device WiFi Password: Choose Password

# When Choosing 'n'
Bluetooth Device Name: Choose Device Name (Depending on Install)
AirPlay Device Name: Choose Device Name (Depending on Install)
Access Point Device Name: Choose Device Name (Depending on Install)
Device WiFi Password: Choose Password (Depending on Install)
```
