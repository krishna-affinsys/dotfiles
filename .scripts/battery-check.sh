#!/bin/bash

battery_path="/sys/class/power_supply/BAT0"
battery_level=$(cat $battery_path/capacity)
charging_status=$(cat $battery_path/status)

low_threshold=20
critical_threshold=5

if [[ $charging_status == "Discharging" ]]; then
    if [ $battery_level -le $critical_threshold ]; then
        dunstify -u critical "Battery Critical" "Battery level is ${battery_level}%! Please connect to a power source immediately."
    elif [ $battery_level -le $low_threshold ]; then
        dunstify -u normal "Battery Low" "Battery level is ${battery_level}%. Please consider connecting to a power source."
    fi
fi

