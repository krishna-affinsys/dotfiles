#!/bin/bash

battery_path="/sys/class/power_supply/BAT0"

low_threshold=35
critical_threshold=10
sleep_seconds=180

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
}


while [[ true ]]; do
  battery_alert_if_needed
  sleep ${sleep_seconds}
done


