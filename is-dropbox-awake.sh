#!/bin/bash
#
# This script monitors for when Dropbox has finished syncing.

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
    elif
        echo -ne "\rDropbox output an unrecognize message. Exiting script."
        echo -ne "\nThe output of \`dropbox status\` is:\n"
        dropbox status
    fi
    sleep 5
done

# Celebrate if it's finally done
if [[ $(dropbox status) == "Up to date" ]]
    echo "IT'S DONE!!!!"
fi
