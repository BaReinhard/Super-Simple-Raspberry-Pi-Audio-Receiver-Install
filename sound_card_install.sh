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
save_original "/etc/asound.conf"
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
save_original "/boot/config.txt"
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
if [ "$SoundCard" != "0" ]
then
	save_original "/boot/config.txt"
    sed -i "s/dtparam=audio=on/#dtparam=audio=on/" /boot/config.txt
fi
if [ "$SoundCard" = "0" ]
then
save_original "/etc/modprobe.d/alsa-base.conf"
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf

elif [ "$SoundCard" = "1" ]
then
save_original "/boot/config.txt"
cat << EOT >>/boot/config.txt
# Enable HiFiberry DAC Light
dtoverlay=hifiberry-dac
EOT
elif [ "$SoundCard" = "2" ]
then
save_original "/boot/config.txt"
cat <<EOT >>/boot/config.txt
# Enable HiFiberry DAC Standard/Pro
dtoverlay=hifiberry-dacplus
EOT
elif [ "$SoundCard" = "3" ]
then
save_original "/boot/config.txt"
cat <<EOT >>/boot/config.txt
# Enable HiFiberry Digi
dtoverlay=hifiberry-digi
EOT

elif [ "$SoundCard" = "4" ]
then
save_original "/boot/config.txt"
cat <<EOT >>/boot/config.txt
# Enable HiFiberry Amp
dtoverlay=hifiberry-amp
EOT
elif [ "$SoundCard" = "5" ]
then
save_original "/boot/config.txt"
cat <<EOT >>/boot/config.txt
# Enable iqaudio-dac
dtoverlay=iqaudio-dac
EOT

elif [ "$SoundCard" = "6" ]
then
save_original "/boot/config.txt"
cat <<EOT >>/boot/config.txt
# Enable iqaudio-dac+
dtoverlay=iqaudio-dacplus
EOT
elif [ "$SoundCard" = "7" ]
then
save_original "/boot/config.txt"
cat <<EOT >>/boot/config.txt
# Enable iqaudio-DigiAMP+
dtoverlay=iqaudio-dacplus,unmute_amp
EOT

elif [ "$SoundCard" = "8" ]
then
save_original "/etc/modprobe.d/alsa-base.conf"
echo "options snd_bcm2835 index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
save_original "/boot/config.txt"
cat <<EOT >>/boot/config.txt
# Enable iqaudio-Digi+
dtoverlay=iqaudio-digi-wm8804-audio
EOT
elif [ "$SoundCard" = "10" ]
then
save_original "/boot/config.txt"
cat <<EOT >>/boot/config.txt
# Enable JustBoom DAC and AMP Card
dtoverlay=justboom-dac
EOT
elif [ "$SoundCard" = "11" ]
then
save_original "/boot/config.txt"
cat <<EOT >>/boot/config.txt
# Enable JustBoom Digi Cards
dtoverlay=justboom-digi
EOT
fi
