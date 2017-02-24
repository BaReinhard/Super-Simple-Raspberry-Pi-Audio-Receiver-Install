#!/bin/sh
# This file will add the proper sound card configurations to your /etc/asound.conf
# I am unsure whether or not you need pulse and pulse_connect, but will be testing if its absolutely necessary.
# If you are not using any sound card please change all the following line of "card 1" to "card 0"
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd_bcm2835 index=0
EOT
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
#dtoverlay=iqaudio-dacplus
EOT

cat << EOT >> /etc/modules
# Hifi Amp+
#snd_soc_bcm2708
#bcm2708_dmaengine
#snd_soc_hifiberry_amp

# Hifi Digi Digi+
#snd_soc_bcm2708
#bcm2708_dmaengine
#snd_soc_hifiberry_digi

# Hifi Standard Pro
#snd_soc_bcm2708
#bcm2708_dmaengine
#snd_soc_pcm512x
#snd_soc_hifiberry_dacplus

# Hifi Dac Dac+ Light
#snd_soc_bcm2708
#bcm2708_dmaengine
#snd_soc_pcm5102a
#snd_soc_hifiberry_dac
EOT
exit 0
