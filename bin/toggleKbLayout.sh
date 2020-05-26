#!/bin/bash

layout=`setxkbmap -query | grep layout | tail -c 3`

if [ $layout == "ca" ]; then
    echo "Switching to US"
    setxkbmap us
else
    echo "Switching to CA-FR"
    setxkbmap ca
fi

