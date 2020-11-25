#!/bin/bash

SINK=$(pacmd list-sinks|awk '/\* index:/{ print $3 }') || "@DEFAULT_SINK@"

# Check if volume is an increase
if [[ "$1" == *"+"* ]]; then
    # Get new volume after increase. If higher than max - exit early
    VOL=$(pacmd list-sinks | grep -A 15 '* index' | awk '/volume: front/{ print $5 }' | sed 's/[%|,]//g')
    INC=$(echo $1 | tr -dc '0-9')
    TOTAL=$((VOL + INC))

    if (( $TOTAL > 100 )); then
        # TODO: Play different sound effect or something
        exit
    fi
fi

pactl set-sink-volume "$SINK" $1
/home/kevin/.dotfiles/bin/sendGoBarSignal.sh SIGRTMIN+5
aplay -q /home/kevin/bin/ding.wav
