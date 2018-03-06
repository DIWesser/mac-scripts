#!/bin/bash
#
# This script prints out the time in the user's preffered non-system timezone.
# If no preferred timezone is set, it prints the system time.
# I'm using this because I keep my computer on UTC for the sake of metadata, 
# but that isn't the timezone where I live.

# If settings file exists
if [ -f $HOME/.config/my-scripts/device-id ] ; then
    # Load it
    settings="$HOME/.config/my-scripts/device-id"
    # Read the timezone from it
    myTimezone=$(grep -iw '^\s*timezone:' $settings | cut -d: -f2 | xargs)
    # And print the time in the timezone
    env TZ=$myTimezone date +"%H:%M %Z"

# If settings file does not exist
else
    # Just print the system time
    date +"%H:%M %Z"
fi
