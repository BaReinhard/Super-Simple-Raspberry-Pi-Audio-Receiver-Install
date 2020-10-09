# Project is no longer being actively worked on, if someone else would like to pick this up, please do so.



# Super Simple Raspberry Pi Audio Receiver Install.
**\*This does not work past Raspbian Stretch**
**\*Stretch Users** Scroll to the bottom for Install Instructions (This is in the testing phase for the moment, please give feedback [here](https://github.com/BaReinhard/Super-Simple-Raspberry-Pi-Audio-Receiver-Install/issues/102)


**\*Requires Raspbian Jessie LITE** you can find the lastest Jessie Lite Image [here](http://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-07-05/)\*
![SSPARI](https://github.com/BaReinhard/Super-Simple-Raspberry-Pi-Audio-Receiver-Install/blob/master/img/SSRPARI_1080_668.png?raw=true)

## SSPARI v2.0

**_Now Live, includes the following new features:_**

* Volumio Compatibility for Bluetooth Only - Installs A2DP Bluetooth Streaming to RPI
* Backing up of original files
* Uninstallation functionality
* Restoring original files
* Updated logging for easier bug testing
* Cleaner install and better support
* Ability to disable Wifi on Bluetooth Connection. Needs to be enabled, but solves choppy bluetooth playback if no external wifi card is available.

## _SNAPCAST Support! Please test it, i have had great success so far._

### This type of Multiroom Audio would not be possible without the awesome Repo:

**_[Snapcast](https://github.com/badaix/snapcast)_** and Badaix. Special Thanks to Totti2 for getting the config just right.

### Additional Thanks to the awesome Repo:

**_[Shairport-Sync](https://github.com/mikebrady/shairport-sync/)_** and Mike Brady for making it so easy to use.

This project has combined several different projects into one, culminating into a plug-and-play Audio Receiver project. It incorporates A2DP Bluetooth, Snapcast, and AirPlay as possible ways to stream music to your Raspberry Pi. When paired with a sound card or HiFi audio DAC, you get high quality stereo audio.

## Changes

* Volumio users can now install the Bluetooth Only option, for the time being no Meta Data is forwarded to the Web Interface, this is a work in progress.
* Addition and support for SnapCast as Server and Client or Both (Will need some manual configuration, creates a very simple multiroom setup)
* Use of External Soundcards
* soxr interpolation with shairport-sync, works well on Raspberry Pi Zero and Raspberry Pi 3, haven't tested on any other boards yet.
* Works great with Sabrent USB Sound Card, HifiBerry Amp+ (I would not recommend this in a car) and HifiBerry DAC+ Pro, other Hifi DAC's should have no different functionality and should work just as well.
* Creates Internet-less Wireless Network (Setup as an AP) to allow users to connect to the network and use AirPlay
* Allows for Bluetooth A2DP, AirPlay, and local files played through Kodi.
* Uses kodi as a GUI, and supports the use of sound cards.
* Supports Infrared remotes, currently setup for the [Matricom IR Remote.](https://www.amazon.com/Quality-Replacement-Controller-Android-Matricom/dp/B018K0GR12)
* Uses custom GPIO pins for Infrared to be used with HifiBerry boards, IQaudIO boards, and JustBoom boards.
* Includes boot configurations in the `/boot/config.txt`.
* Supports All Hifiberry DAC Boards, IQaudIO, JustBoom, and USB sound cards.

#### This is a further fixed version with the addition of being able to Deploy the project in car without a Wireless Network from my original Raspberry Pi Audio Receive Install repo which was forked from adenbeckitt, with a few changes made for shairport-sync dependencies and configuration files, which is a general fix from ehsmaes' version. This now works with Raspbian Jessie.

## Known Issues

* For the time being, I have not been able to get espeak to work with a soundcard. I will be working to get this working either with espeak or another program.
* Unsure how Android will act on a wireless network without internet, iOS doesn't display the WiFi signals and will use Cellular Data for data requirements. However, iOS devices still can play local music to the Pi without any cellular data.
* Raspberry Pi Zero W (new Model with Bluetooth and Wireless built-in) is likely supported and will work. Although, some resource intensive processes may suffer.
* Doesn't work for Raspbian Stretch (NOOBS ships with Stretch, so you will need to use the latest Raspbian Jessie Lite Image)

## Install

#### This will install on the latest Raspbian Jessie, with just the following commands.

```
pi@raspberrypi:~/ $ sudo apt-get update
pi@raspberrypi:~/ $ sudo apt-get install git
pi@raspberrypi:~/ $ git clone https://github.com/BaReinhard/Super-Simple-Raspberry-Pi-Audio-Receiver-Install.git
pi@raspberrypi:~/ $ cd Super-Simple-Raspberry-Pi-Audio-Receiver-Install
pi@raspberrypi:~/Super-Simple-Raspberry-Pi-Audio-Receiver-Install $ sudo ./install.sh
1. Install the Raspberry Pi Audio Receiver Car Installation
2. Install the Raspberry Pi Audio Receiver Home Installation
3. Install the Raspberry Pi Network Without Internet Installation (For teaching!)
4. Install the Bluetooth Only Installation
5. Install the Snapcast Installation (BETA), choose from Snapcast Server, Client, or Both (Requires Minor Configuration)
6. Install a Custom Raspberry Pi Audio Receiver
Which installation would you like to choose? (1/2/3/4/5/6) : Choose 1, 2, 3, 4, 5, or 6
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

**_Looking for Devs to Help Support/Futher This Project_**

### Stretch-Install

```
git clone https://github.com/bareinhard/super-simple-raspberry-pi-audio-receiver-install
cd super-simple-raspberry-pi-audio-receiver-install
git checkout stretch-fix
sudo ./install.sh
```


**Donation**
***Now graciously accepting donations. Donations are not required, but donations do help to keep this project alive and up to date***
[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://paypal.me/pools/c/812h247JvP)
