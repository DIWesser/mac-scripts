#!/bin/bash
#
# This script prints out the time in the user's preffered non-system timezone.
# If no preferred timezone is set, it prints the system time.
# I'm using this because I keep my computer on UTC for the sake of metadata, 
# but that isn't the timezone where I live.

settings="$HOME/.config/diwesser/device-id"
# If settings file exists
if [ -f $settings ] ; then
    # Read the timezone from settings and print the time in the timezone
    env TZ=$(grep -iw '^\s*timezone:' $settings | cut -d: -f2 | xargs) \
        date +"%H:%M %Z"

# If settings file does not exist
else
    # Just print the system time
    date +"%H:%M %Z"
fi
