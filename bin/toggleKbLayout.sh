#!/bin/bash

layout=`setxkbmap -query | grep layout | tail -c 3`

if [ $layout == "ca" ]; then
    setxkbmap us
else
    setxkbmap ca
fi

~/.dotfiles/bin/sendGoBarSignal.sh SIGRTMIN+6
