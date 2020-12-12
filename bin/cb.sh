#!/bin/bash
bluetoothctl scan on &
bluetoothctl connect 0C:3B:50:5D:D5:BC
bluetoothctl scan off
