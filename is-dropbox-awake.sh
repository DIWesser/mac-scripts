#!/bin/bash
#
# This is a stort scrip to monitor whether or not Dropbox has finished syncing.

# Loop every 5 second until Dropbox says it's done
while [[ $(dropbox status) != "Up to date" ]] ; do
    # If Dropbox is just starting up
    if [[ $(dropbox status) == "Starting..." ]] ; then
        echo -ne "\rDropbox hasn't woken up yet."
        sleep 5
    # If Dropbox is indexing
    elif [[ $(dropbox status | grep Indexing) == "Indexing..." ]] ; then
        echo -ne "\rDropbox is making a todo list."
        sleep 5
    # If Dropbox is syncing
    elif [[ $(dropbox status | grep Syncing | cut -d' ' -f 1) == "Syncing" ]]
        then
            echo -ne "\rDropbox is actually syncing (finally)."
    fi
    sleep 5
done

echo "IT'S DONE!!!!"
