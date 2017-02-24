#!/bin/bash
#say() {
#    local IFS=+;
#    if ! /usr/bin/mplayer -softvol -volume 60 -ao alsa -really-quiet -noconsolecontrols "https://translate.google.com/translate_tts?ie=UTF-8&tl=en&client=tw-ob&q=$*"; then
        espeak $*
#    fi
#} 2>/dev/null

#say $*