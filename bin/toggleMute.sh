#!/bin/bash
muted=`pacmd list-sinks|grep -A 15 '* index'|awk '/muted:/{ print $2 }'`

if [ $muted == "no" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ 1
else
    pactl set-sink-mute @DEFAULT_SINK@ 0
fi

~/.dotfiles/bin/sendGoBarSignal.sh SIGRTMIN+5
