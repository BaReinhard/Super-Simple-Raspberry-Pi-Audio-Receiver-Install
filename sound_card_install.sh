#!/bin/sh
# This file will add the proper sound card configurations to your /etc/asound.conf
# I am unsure whether or not you need pulse and pulse_connect, but will be testing if its absolutely necessary.
# If you are not using any sound card please change all the following line of "card 1" to "card 0"

if [ -z "$SoundCard ]
then 
    read -p "Which sound card are you using" SoundCard
fi
if [ -z "$exc" ]
then
    source functions.sh
    source dependencies.sh
fi
if [ $SoundCard = "0" ]
then
exc sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
exc sudo cat <<EOT >> /etc/asound.conf
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
exc sudo cat <<EOT >> /boot/config.txt
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
elif [ $SoundCard = "1" ]
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
exc sudo cat <<EOT >>/boot/config.txt
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
exc sed -i '56 s/^/#/' /boot/config.txt # fixes problem with onboard sound card
elif [ $SoundCard = "2" ]
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
exc sudo cat <<EOT >>/boot/config.txt
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
exc sed -i '56 s/^/#/' /boot/config.txt
elif [ $SoundCard = "3" ]
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
exc sudo cat <<EOT >>/boot/config.txt
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
exc sed -i '56 s/^/#/' /boot/config.txt
elif [ $SoundCard = "4" ]
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
exc sudo cat <<EOT >>/boot/config.txt
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
exc sed -i '56 s/^/#/' /boot/config.txt
elif [ $SoundCard = "5" ]
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
exc sed -i '56 s/^/#/' /boot/config.txt
elif [ $SoundCard = "6" ]
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
exc sed -i '56 s/^/#/' /boot/config.txt
elif [ $SoundCard = "7" ]
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

# Enable iqaudio-Digi+
#dtoverlay=iqaudio-digi-wm8804-audio

# Enable iqaudio-DigiAMP+
dtoverlay=iqaudio-dacplus,unmute_amp

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT
exc sed -i '56 s/^/#/' /boot/config.txt
elif [ $SoundCard = "8" ]
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
dtoverlay=iqaudio-digi-wm8804-audio

# Enable JustBoom DAC and AMP Card
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi


EOT
exc sed -i '56 s/^/#/' /boot/config.txt
elif [ $SoundCard = "9" ]
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
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT
exc sed -i '56 s/^/#/' /boot/config.txt
elif [ $SoundCard = "10" ]
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
exc sed -i '56 s/^/#/' /boot/config.txt
elif [ $SoundCard = "11" ]
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
#dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
dtoverlay=justboom-digi
EOT
exc sed -i '56 s/^/#/' /boot/config.txt
fi
