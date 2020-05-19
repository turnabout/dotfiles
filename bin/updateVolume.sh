#!/bin/bash
amixer -q sset Master $1
/home/kevin/.dotfiles/bin/sendGoBarSignal.sh SIGRTMIN+5
aplay -q /home/kevin/bin/ding.wav
