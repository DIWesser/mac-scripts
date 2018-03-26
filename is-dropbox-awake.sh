#!/bin/bash
#
# This script monitors for when Dropbox has finished syncing.
#
# I should probably incorporate this into the script, but for now:
#
# If you have too many files in Dropbox, it will not have permission to monitor
# to monitor all of the contents of the Dropbox folder. This can be fixed either
# by increasing the number of files that can be monitored. To do this until the
# next reboot, run:
#     sudo sysctl fs.inotify.max_user_instances=256
#     sudo sysctl fs.inotify.max_user_watches=1048576
# To do so perminantly, add the following lines to /etc/sysctl.conf
#     fs.inotify.max_user_watches = 1048576
#     fs.inotify.max_user_instances = 256
# Source: https://askubuntu.com/questions/247461/

startTime=$(date +%s)
maxWaitTime=300       # Time before erroring out in seconds

# Loop every 5 seconds until Dropbox says it's done
while [[ $(dropbox status) != "Up to date" ]] ; do
    # If Dropbox is just starting up
    if [[ $(dropbox status) == "Starting..." ]] ; then
        echo -ne "\rDropbox hasn't woken up yet."
        # Timeout if Dropbox is frozen
        if [[ $(date +%s) -ge $startTime+$maxWaitTime ]] ; then
            echo -ne "\rDropbox has been starting for five minutes."
            echo -ne " You may need to restart it."
            exit 1
        fi
    # If Dropbox is indexing
    elif [[ $(dropbox status | grep Indexing) == "Indexing..." ]] ; then
        echo -ne "\rDropbox is making a todo list."
    # If Dropbox is syncing
    elif [[ $(dropbox status | grep Syncing | cut -d' ' -f 1) == "Syncing" ]]
        then
            echo -ne "\rDropbox is actually syncing (finally)."
    elif [[ $(dropbox status) == "Dropbox isn't running!" ]] ; then
        dropbox start
        echo
        echo -ne "\rDropbox was not running."
    else
        echo -ne "\rDropbox output an unrecognize message. Exiting script."
        echo -ne "\nThe output of \`dropbox status\` is:\n"
        dropbox status
        exit 1
    fi
    sleep 5
done

# Celebrate if it's finally done
if [[ $(dropbox status) == "Up to date" ]] ; then
    echo "IT'S DONE!!!!"
fi
