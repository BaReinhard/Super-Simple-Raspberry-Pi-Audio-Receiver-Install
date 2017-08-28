# Super Simple Raspberry Pi Audio Receiver Install. 
### Looking for Devs to Help Support/Futher This Project
### This install has replaced [Raspberry Pi Audio Receiver Install Car Version](https://github.com/BaReinhard/Raspberry-Pi-Audio-Receiver-Install-Car-Install), [Raspberry Pi Audio Receiver Install Home Version](https://github.com/BaReinhard/Raspberry-Pi-Audio-Receiver-Install), and [Network Without Internet](https://github.com/BaReinhard/Network-Without-Internet). The new version allows for the Installation Package of Home, Car, Network Without Internet, and a custom Installation (where you choose what portions of the project you want installed)
This project has combined several different projects into one, culminating into a plug-and-play Audio Receiver project. It incorporates A2DP, AirPlay, and Auxillary line input as possible ways to stream music to your Raspberry Pi. When paired with a sound card or HiFi audio DAC, with the exception of Aux Line Input, you get high quality stereo audio. 
## Changes
* Use of External Soundcards
* soxr interpolation with shairport-sync, works well on Raspberry Pi Zero and Raspberry Pi 3, haven't tested on any other boards yet.
* Works great with Sabrent USB Sound Card, HifiBerry Amp+ (I would not recommend this in a car), and will shortly be testing this with a HifiBerry DAC+ Pro.
* Creates Internet-less Wireless Network (Setup as an AP) to allow users to connect to the network and use AirPlay 
* Allows for Bluetooth A2DP, AirPlay, and local files played through Kodi.
* Uses kodi as a GUI, and supports the use of sound cards.
* Supports Infrared remotes, currently setup for the [Matricom IR Remote.](https://www.amazon.com/Quality-Replacement-Controller-Android-Matricom/dp/B018K0GR12)
* Uses custom GPIO pins for Infrared to be used with HifiBerry boards, IQaudIO boards, and JustBoom boards.
* Includes boot configurations in the `/boot/config.txt`.
* Supports All Hifiberry DAC Boards, IQaudIO, JustBoom, and USB sound cards.


#### This is a further fixed version with the addition of being able to Deploy the project in car without a Wireless Network from my original Raspberry Pi Audio Receive Install repo which was forked from adenbeckitt, with a few changes made for shairport-sync dependencies and configuration files, which is a general fix from ehsmaes' version. This now works with Raspbian Jessie.
#### How about that run on sentence. TLDR; adenbeckitt created a new repo to get ehsmaes' version to work on Raspbian Jessie. I then forked the repo to add some more dependencies and features. Most of the work for this project has been done by adenbeckitt and ehsmaes.

## Known Issues

* For the time being, I have not been able to get espeak to work with a soundcard. I will be working to get this working either with espeak or another program.
* Unsure how Android will act on a wireless network without internet, iOS doesn't display the WiFi signals and will use Cellular Data for data requirements. However, iOS devices still can play local music to the Pi without any cellular data.
* Raspberry Pi Zero will need a WiFi card to use the new Access Point feature, some cards are not compatible with hostapd right out of the box and may require a forked repo of hostapd. If you are using a tp-link usb adapter you can follow the guide here to fix how the current install feature has set this up. GUIDE: [Pi Zero hostapd Fix](https://bareinhard.github.io/2017/02/15/Fix-hostapd-Raspberry-Pi-Zero.html)
* Raspberry Pi Zero W (new Model with Bluetooth and Wireless built-in) is likely supported and will work, testing will begin once I receive the new board (Should arrive this week). However, since the Raspberry Pi Foundation has stated the following, I see no reason why it wouldn't work with hostapd as expected.

> It uses the same Cypress CYW43438 wireless chip as Raspberry Pi 3 Model B to provide 802.11n wireless LAN and Bluetooth 4.0 connectivity. 

## Install
#### This will install on the latest Raspbian Jessie, with just the following commands.

```
pi@raspberrypi:~/ $ sudo apt-get install git
pi@raspberrypi:~/ $ git clone https://github.com/BaReinhard/Super-Simple-Raspberry-Pi-Audio-Receiver-Install.git
pi@raspberrypi:~/ $ cd Super-Simple-Raspberry-Pi-Audio-Receiver-Install
pi@raspberrypi:~/Super-Simple-Raspberry-Pi-Audio-Receiver-Install $ sudo ./install.sh
1. Install the Raspberry Pi Audio Receiver Car Installation
2. Install the Raspberry Pi Audio Receiver Home Installation
3. Install the Raspberry Pi Network Without Internet Installation (For teaching!)
4. Install the Volumio (Bluetooth Only) Installation
5. Install a Custom Raspberry Pi Audio Receiver
Which installation would you like to choose? (1/2/3/4/5) : Choose 1, 2, 3, 4, or 5
Do you want all the Devices to use the same name? (y/n) : Choose y or n

# When Choosing 'y'
Device name: Choose Device Name
Device WiFi Password: Choose Password

# When Choosing 'n'
Bluetooth Device Name: Choose Device Name (Depending on Install)
AirPlay Device Name: Choose Device Name (Depending on Install)
Access Point Device Name: Choose Device Name (Depending on Install)
Device WiFi Password: Choose Password (Depending on Install)

0. No Sound Card
1. HifiBerry DAC Light
2. HifiBerry DAC Standard/Pro
3. HifiBerry Digi+
4. Hifiberry Amp+
5. Pi-IQaudIO DAC
6. Pi-IQaudIO DAC+, Pi-IQaudIO DACZero, Pi-IQaudIO DAC PRO
7. Pi-IQaudIO DigiAMP
8. Pi-IQaudIO Digi+
9. USB Sound Card
10. JustBoom DAC and AMP Cards
11. JustBoom Digi Cards
	
Which Sound Card are you using? (0/1/2/3/4/5/6/7/8/9/10/11) :  Sound Card Choice 
```
