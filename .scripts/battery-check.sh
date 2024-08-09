#!/bin/bash

battery_path="/sys/class/power_supply/BAT0"

low_threshold=35
critical_threshold=10

normal_sleep_seconds=600
critical_sleep_seconds=100

battery_alert_if_needed() {
  battery_level=$(cat $battery_path/capacity)
  charging_status=$(cat $battery_path/status)

  if [[ $charging_status == "Discharging" ]]; then
      if [ $battery_level -le $critical_threshold ]; then
          dunstify -u critical "Battery Critical" "Battery level is ${battery_level}%! Please connect to a power source immediately."
      elif [ $battery_level -le $low_threshold ]; then
          dunstify -u normal "Battery Low" "Battery level is ${battery_level}%. Please consider connecting to a power source."
      fi
  fi

  if [ $battery_level -le $critical_threshold ]; then
      sleep_seconds=$critical_sleep_seconds
  else
      sleep_seconds=$normal_sleep_seconds
  fi
}


while true; do
  battery_alert_if_needed
  sleep ${sleep_seconds}
done
