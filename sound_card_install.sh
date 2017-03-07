#!/bin/sh
# This file will add the proper sound card configurations to your /etc/asound.conf
# I am unsure whether or not you need pulse and pulse_connect, but will be testing if its absolutely necessary.
# If you are not using any sound card please change all the following line of "card 1" to "card 0"
read -p "Which sound card are you using" SoundCard
if [ $SoundCard = "0" ]
then
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf

pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:0,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 0
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
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
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 1
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
}
EOT
sudo cat <<EOT >>/boot/config.txt
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
elif [ $SoundCard = "2" ]
then
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 1
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
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
elif [ $SoundCard = "3" ]
then
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 1
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
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
elif [ $SoundCard = "4" ]
then
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 1
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
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
elif [ $SoundCard = "5" ]
then
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 1
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
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
elif [ $SoundCard = "6" ]
then
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 1
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
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
elif [ $SoundCard = "7" ]
then
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 1
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
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
elif [ $SoundCard = "8" ]
then
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 1
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
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
elif [ $SoundCard = "9" ]
then
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 1
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
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
elif [ $SoundCard = "10" ]
then
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 1
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
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
dtoverlay=justboom-dac

# Enable JustBoom Digi Cards
#dtoverlay=justboom-digi
EOT
elif [ $SoundCard = "11" ]
then
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
pcm.dmixer{
    type dmix
       ipc_key 1024
       slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 44100
       }
       bindings {
               0 0
               1 1
       }
}
ct.dmixer{
    type hw
    card 1
}
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
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
exit 0
