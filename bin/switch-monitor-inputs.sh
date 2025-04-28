#!/bin/bash
#
# switch-monitor-inputs.sh
# 
# Dependencies:
# - ddcutil
#
# Usage:
# bash switch-monitor-inputs.sh [MONITOR_KEY]
#
# Supported keys listed below in the "monitor_info_mapping" map.

# Input sources
input_source_hdmi_1="0x11"    # 0x11
input_source_usb_c="0x1b"     # 0x1b
input_source_dp_1="0x0f"      # 0x0f
input_source_unknown_1="0x13" # 0x13

# Human-readable input sources
declare -A input_source_names=(
  [$input_source_hdmi_1]="HDMI-1"
  [$input_source_usb_c]="USB-C"
  [$input_source_dp_1]="DP-1"
  [$input_source_unknown_1]="Unknown"
)

# Map of human-readable monitor IDs into corresponding monitor information.
#
# Info in the values is split like this:
# [Serial number] [Input source 1] [Input source 2]
declare -A monitor_info_mapping=(
  # TODO: fill in
  # [monitor1]="C04C4V3"
  # [monitor2]="C0294V3"
  [work]="CP7L834 $input_source_hdmi_1 $input_source_usb_c"
)

get_current_input() {
    # Arguments:
    # $1 is the serial number of the monitor
    monitor_sn="$1"

    # Get the current input source for the monitor based on its serial number
    current_input=$(ddcutil --sleep-multiplier 0.1 --sn "$monitor_sn" getvcp 0x60 | grep -oP '(?<=sl=0x)[0-9a-fA-F]+')

    # Add the '0x' prefix to the result and return it
    echo "0x$current_input"
}

update_input() {
    # Arguments:
    # $1 is the serial number of the monitor
    # $2 is the input to update to
    monitor_sn="$1"
    new_input=$2

    ddcutil --sleep-multiplier 0.1 --sn "$monitor_sn" setvcp 0x60 $2
}

toggle_input() {
    # Arguments:
    # $1 is the serial number of the monitor
    # $2 is the first input source from which we can toggle
    # $3 is the second input source from which we can toggle

    monitor_name="$1"
    monitor_sn="$2"
    input_1="$3"
    input_2="$4"


    input_1_name="${input_source_names[$input_1]}"
    input_2_name="${input_source_names[$input_2]}"


    current_input=$(get_current_input "$monitor_sn")

    if [ "$current_input" == "$input_1" ]; then
        echo "Switching monitor '${monitor_name}' input: $input_1_name -> $input_2_name"
        update_input $monitor_sn $input_2
    else
        echo "Switching monitor '${monitor_name}' input: $input_2_name -> $input_1_name"
        update_input $monitor_sn $input_1
    fi
}

# 
# Script start
# 
monitor_name=$1
monitor_info="${monitor_info_mapping[$monitor_name]}"

if [[ -z "$monitor_info" ]]; then
  echo "Unknown monitor key: '$monitor_key'"
  echo ""
  echo "Supported keys:"
  echo "- monitor1"
  echo "- monitor2"
  echo "- work"
  exit 1
fi

# Read corresponding monitor info & pass to function
read -r serial_number input_source_1 input_source_2 <<< "$monitor_info"

monitor_info="${monitor_info_mapping[$monitor_name]}"

toggle_input $monitor_name $serial_number $input_source_1 $input_source_2

