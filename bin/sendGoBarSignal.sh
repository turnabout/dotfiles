#!/bin/bash

# Sends a custom signal to the go status bar's process
# First script argument is the signal to send (SIGUSR1, SIGRTMIN+2, etc)

# Get go status bar's PID
statusbarPID=`ps aux | grep /home/kevin/go/bin/gostatus | head -n 1 | awk -F ' ' '{print $2}'`

# Send given signal
kill -s $1 $statusbarPID
