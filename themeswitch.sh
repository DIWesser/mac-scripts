#!/bin/bash

# Todo
# - dayNight is really crude and can't handle time wrapping

debugOutput=false
timeZone="America/Halifax"           # Enter "system" to use system time
location="CAXX0183"                  # Location for weather.com
dayTheme="Ant"                       # Light theme
nightTheme="macOS Mojave Dark mode"  # Dark theme
dayIcon="Suru"                       # Light Icons
nightIcon="macOS"                    # Dark Icons
dayTimeStart="0630"                  # Start of day colours
nightTimeStart="2000"                # Start of night colours


# Change GTK theme
# - Takes theme name as string
setTheme() {
    local theme="$1"
    local icons="$2"
    if [[ $debugOutput == true ]] ; then
        echo "\`setTheme\` function detects theme as $theme."
        echo "Changing theme."
    fi
    gsettings set org.gnome.desktop.interface gtk-theme "$theme"
    gsettings set org.gnome.desktop.wm.preferences theme "$theme"
    gsettings set org.gnome.desktop.interface icon-theme "$icons"
}


# Find sunrise and sunset time
# - Takes no input, sets global variables sunsetTime and sunriseTime
sunriseSunset(){
    # Obtain sunrise and sunset raw data from weather.com
    sun_times=$( curl -s  https://weather.com/weather/today/l/$location | sed 's/<span/\n/g' | sed 's/<\/span>/\n/g'  | grep -E "dp0-details-sunrise|dp0-details-sunset" | tr -d '\n' | sed 's/>/ /g' | cut -d " " -f 4,8 )

    # Extract sunrise and sunset times and convert to 24 hour format
    sunriseTime=$(date --date="`echo $sun_times | awk '{ print $1}'` AM" +%R)
    sunsetTime=$(date --date="`echo $sun_times | awk '{ print $2}'` PM" +%R)
}


# Finds if current time is in defined day period or night period.
# Takes no input, returns "day" or "night"
dayNight(){
    local currentTime=$(env TZ="$timeZone" date +"%H%M")
    (( "$dayTimeStart" < "$currentTime" && "$currentTime" < "$nightTimeStart" ))\
        && echo day || echo night
}

if [[ $(dayNight) == "day" ]] ; then
    setTheme "$dayTheme" "$dayIcon"
else
    setTheme "$nightTheme" "$nightIcon"
fi
