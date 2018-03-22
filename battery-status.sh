#!/bin/bash
#
# This script shows prints the battery percentage and an icon that indicates
# whether or not the computer is plugged into power.
#
# This script is designed for use in a status bar.

percentage=$(cat /sys/class/power_supply/BAT0/uevent | grep POWER_SUPPLY_CAPACITY= | cut -d'=' -f2)
powerSource="!"

if [[ $(cat /sys/class/power_supply/BAT0/uevent | grep POWER_SUPPLY_STATUS |
      cut -d'=' -f2) == "Discharging" ]] ; then
    powerSource="🔋"
elif [[ $(cat /sys/class/power_supply/BAT0/uevent | grep POWER_SUPPLY_STATUS |
        cut -d'=' -f2) == "Charging" ]] ; then
    powerSource="⚇ "
elif [[ $(cat /sys/class/power_supply/BAT0/uevent | grep POWER_SUPPLY_STATUS |
        cut -d'=' -f2) == "Unknown" ]] ; then
    powerSource="⚇ "
else
    powerSource="!"
fi

#echo $percentage% $powerSource
echo $powerSource$percentage%
