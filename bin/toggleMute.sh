#!/bin/bash
muted=`pacmd list-sinks | awk '/muted/ { print $2 }'`

if [ $muted == "no" ]; then
    pactl set-sink-mute 0 1
else
    pactl set-sink-mute 0 0
fi

/home/kevin/.dotfiles/bin/sendGoBarSignal.sh SIGRTMIN+5
