#!/bin/bash

while [[ $(dropbox status) != "Up to date" ]] ; do
    if [[ $(dropbox status) == "Starting..." ]] ; then
        echo -ne "Dropbox hasn't woken up yet.\r"
        sleep 5
    elif [[ $(dropbox status | grep Indexing) == "Indexing..." ]] ; then
        echo -ne "Dropbox is making a todo list.\r"
        sleep 5
    elif [[ $(dropbox status | grep Syncing | cut -d' ' -f 1) == "Syncing" ]]
        then
            echo -ne "Dropbox is actually syncing (finally).\r"
            sleep 5
    fi
done

echo "IT'S DONE!!!!"
