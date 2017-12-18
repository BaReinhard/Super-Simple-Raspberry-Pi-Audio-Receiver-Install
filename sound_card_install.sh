#!/bin/bash
# This file will add the proper sound card configurations to your /etc/asound.conf
# I am unsure whether or not you need pulse and pulse_connect, but will be testing if its absolutely necessary.
# If you are not using any sound card please change all the following line of "card 1" to "card 0"
if [ $SUDO_USER ]; 
then 
	user=$SUDO_USER;echo 
else 
	echo "Must be run as root user!!" 
	exit 1 
fi
if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi
if [ -z "$SoundCard" ]
then 
    installlog "0. No Sound Card"
	installlog "1. HifiBerry DAC Light"
	installlog "2. HifiBerry DAC Standard/Pro"
	installlog "3. HifiBerry Digi+"
	installlog "4. Hifiberry Amp+"
	installlog "5. Pi-IQaudIO DAC"
	installlog "6. Pi-IQaudIO DAC+, Pi-IQaudIO DACZero, Pi-IQaudIO DAC PRO"
	installlog "7. Pi-IQaudIO DigiAMP"
	installlog "8. Pi-IQaudIO Digi+"
	installlog "9. USB Sound Card"
	installlog "10. JustBoom DAC and AMP Cards"
	installlog "11. JustBoom Digi Cards"
	SoundCard="SoundCard"
	while true
	do
		read -p "Which Sound Card are you using? (0/1/2/3/4/5/6/7/8/9/10/11) : " SoundCard
		case "$SoundCard" in
		[0-9]|10|11)
			break
		;;
		*)
			echo "Please enter a valid choice"
		;;
		esac
	done
fi
if [ $SoundCard = "0" ]
then
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf

sudo cat << EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 0
}
ctl.pulse {
    type pulse
    card 0
}

pcm.!default {
    type hw
    card 0
}
ctl.!default {
    type hw
    card 0
}
EOT
sudo cat <<EOT >> /boot/config.txt
# Enable HiFiberry Amp
#dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
#dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
#dtoverlay=hifiberry-dacplus


# Enable HiFiberry Digi
#dtoverlay=hifiberry-digi

# Enable iqaudio-dac
#dtoverlay=iqaudio-dac

# Enable iqaudio-dat+
#dtoverlay=iqaudio-dacplus

# Enable iqaudio-DigiAMP+
#dtoverlay=iqaudio-dacplus,unmute_amp

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT
elif [ "$SoundCard" = "1" ]
then
exc sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
exc sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT
sudo cat << EOT >>/boot/config.txt
# Enable HiFiberry Amp
#dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
#dtoverlay=hifiberry-dacplus

# Enable HiFiberry Digi
#dtoverlay=hifiberry-digi

# Enable iqaudio-dac
#dtoverlay=iqaudio-dac

# Enable iqaudio-dat+
#dtoverlay=iqaudio-dacplus

# Enable iqaudio-DigiAMP+
#dtoverlay=iqaudio-dacplus,unmute_amp

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT
elif [ "$SoundCard" = "2" ]
then
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
sudo cat << EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT
sudo cat <<EOT >>/boot/config.txt
# Enable HiFiberry Amp
#dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
#dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
dtoverlay=hifiberry-dacplus

# Enable HiFiberry Digi
#dtoverlay=hifiberry-digi

# Enable iqaudio-dac
#dtoverlay=iqaudio-dac

# Enable iqaudio-dat+
#dtoverlay=iqaudio-dacplus

# Enable iqaudio-DigiAMP+
#dtoverlay=iqaudio-dacplus,unmute_amp

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT
elif [ "$SoundCard" = "3" ]
then
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT
sudo cat <<EOT >>/boot/config.txt
# Enable HiFiberry Amp
#dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
#dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
#dtoverlay=hifiberry-dacplus


# Enable HiFiberry Digi
dtoverlay=hifiberry-digi

# Enable iqaudio-dac
#dtoverlay=iqaudio-dac

# Enable iqaudio-dat+
#dtoverlay=iqaudio-dacplus

# Enable iqaudio-DigiAMP+
#dtoverlay=iqaudio-dacplus,unmute_amp

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT

elif [ "$SoundCard" = "4" ]
then
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT
sudo cat <<EOT >>/boot/config.txt
# Enable HiFiberry Amp
dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
#dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
#dtoverlay=hifiberry-dacplus


# Enable HiFiberry Digi
#dtoverlay=hifiberry-digi

# Enable iqaudio-dac
#dtoverlay=iqaudio-dac

# Enable iqaudio-dat+
#dtoverlay=iqaudio-dacplus

# Enable iqaudio-DigiAMP+
#dtoverlay=iqaudio-dacplus,unmute_amp

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT
elif [ "$SoundCard" = "5" ]
then
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT
sudo cat <<EOT >>/boot/config.txt
# Enable HiFiberry Amp
#dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
#dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
#dtoverlay=hifiberry-dacplus


# Enable HiFiberry Digi
#dtoverlay=hifiberry-digi

# Enable iqaudio-dac
dtoverlay=iqaudio-dac

# Enable iqaudio-dat+
#dtoverlay=iqaudio-dacplus

# Enable iqaudio-DigiAMP+
#dtoverlay=iqaudio-dacplus,unmute_amp

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT

elif [ "$SoundCard" = "6" ]
then
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT
sudo cat <<EOT >>/boot/config.txt
# Enable HiFiberry Amp
#dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
#dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
#dtoverlay=hifiberry-dacplus


# Enable HiFiberry Digi
#dtoverlay=hifiberry-digi

# Enable iqaudio-dac
#dtoverlay=iqaudio-dac

# Enable iqaudio-dat+
dtoverlay=iqaudio-dacplus

# Enable iqaudio-DigiAMP+
#dtoverlay=iqaudio-dacplus,unmute_amp

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT
elif [ "$SoundCard" = "7" ]
then
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT
sudo cat <<EOT >>/boot/config.txt
# Enable HiFiberry Amp
#dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
#dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
#dtoverlay=hifiberry-dacplus


# Enable HiFiberry Digi
#dtoverlay=hifiberry-digi

# Enable iqaudio-dac
#dtoverlay=iqaudio-dac

# Enable iqaudio-dac+
#dtoverlay=iqaudio-dacplus

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable iqaudio-DigiAMP+
dtoverlay=iqaudio-dacplus,unmute_amp

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT

elif [ "$SoundCard" = "8" ]
then
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT
sudo cat <<EOT >>/boot/config.txt
# Enable HiFiberry Amp
#dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
#dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
#dtoverlay=hifiberry-dacplus


# Enable HiFiberry Digi
#dtoverlay=hifiberry-digi

# Enable iqaudio-dac
#dtoverlay=iqaudio-dac

# Enable iqaudio-dac+
#dtoverlay=iqaudio-dacplus

# Enable iqaudio-DigiAMP+
#dtoverlay=iqaudio-dacplus,unmute_amp

# Enable iqaudio-Digi+
dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi


EOT
elif [ "$SoundCard" = "9" ]
then
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT
sudo cat <<EOT >>/boot/config.txt
# Enable HiFiberry Amp
#dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
#dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
#dtoverlay=hifiberry-dacplus


# Enable HiFiberry Digi
#dtoverlay=hifiberry-digi

# Enable iqaudio-dac
#dtoverlay=iqaudio-dac

# Enable iqaudio-dac+
#dtoverlay=iqaudio-dacplus

# Enable iqaudio-DigiAMP+
#dtoverlay=iqaudio-dacplus,unmute_amp

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT
elif [ "$SoundCard" = "10" ]
then
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT
exc sudo cat <<EOT >>/boot/config.txt
# Enable HiFiberry Amp
#dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
#dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
#dtoverlay=hifiberry-dacplus


# Enable HiFiberry Digi
#dtoverlay=hifiberry-digi

# Enable iqaudio-dac
#dtoverlay=iqaudio-dac

# Enable iqaudio-dac+
#dtoverlay=iqaudio-dacplus

# Enable iqaudio-DigiAMP+
#dtoverlay=iqaudio-dacplus,unmute_amp

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT
elif [ "$SoundCard" = "11" ]
then
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT
sudo cat <<EOT >>/boot/config.txt
# Enable HiFiberry Amp
#dtoverlay=hifiberry-amp

# Enable HiFiberry DAC Light
#dtoverlay=hifiberry-dac

# Enable HiFiberry DAC Standard/Pro
#dtoverlay=hifiberry-dacplus

# Enable HiFiberry Digi
#dtoverlay=hifiberry-digi

# Enable iqaudio-dac
#dtoverlay=iqaudio-dac

# Enable iqaudio-dac+
#dtoverlay=iqaudio-dacplus

# Enable iqaudio-DigiAMP+
#dtoverlay=iqaudio-dacplus,unmute_amp

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
dtoverlay=justboom-digi
EOT
fi
