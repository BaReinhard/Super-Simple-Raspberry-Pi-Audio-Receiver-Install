# Super Simple Raspberry Pi Audio Receiver Install. 
***Requires Raspbian Jessie LITE** you can find the lastest Jessie Lite Image [here](http://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-07-05/)*
![SSPARI](https://github.com/BaReinhard/Super-Simple-Raspberry-Pi-Audio-Receiver-Install/blob/master/img/SSRPARI_1080_668.png?raw=true)
## SSPARI v2.0
***Now Live, includes the following new features:***
* backing up of original files
* uninstallation functionality
* restoring original files
* updated logging for easier bug testing
* cleaner install and better support


## *SNAPCAST Support! Please test it out! Requires minor configuration.*
#### I Suggest Running a Pi as either a SnapServer or SnapClient, as I haven't had much testing with it. I believe it is possible for both but have yet to find a solid solution to do so.
* When connecting to Snapcast Server via AirPlay, it will play to /tmp/snapfifo, all snap clients will need to manually move-sink-input from pulseaudio sink-input to soundcard. (In the future this will be automated, somehow...)
* When connecting to Snapcast Server via Bluetooth, Snapcast server will need to move-sink-input from pulseaudio sink-input to Snapcast sink-out, additionally, all Snapcast servers will need to move-sink-input from pulseaudio sink-input to soundcard. (This will also be automated in the future, somehow...)
* Snapclients, installed with this repo will have the ability to play via Bluetooth, AirPlay, and Snapclient. There may be some configuration once connected from any input. Airplay should play to soundcard automatically, but bluetooth and snapclient will need to be moved to soundcard output via `sudo pactl move-sink-input $sinkinput $sinkoutput`, eventually this will be controlled via web ui or CLI bin script.



This project has combined several different projects into one, culminating into a plug-and-play Audio Receiver project. It incorporates A2DP Bluetooth, Snapcast, and AirPlay as possible ways to stream music to your Raspberry Pi. When paired with a sound card or HiFi audio DAC, you get high quality stereo audio. 
## Changes
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


***Looking for Devs to Help Support/Futher This Project***
