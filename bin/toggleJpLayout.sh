#!/bin/bash

engine=$(ibus engine)

if [ "$engine" = "mozc-jp" ]; then
    ibus engine xkb:us::eng
else
    ibus engine mozc-jp
fi

~/.dotfiles/bin/sendGoBarSignal.sh SIGRTMIN+6
