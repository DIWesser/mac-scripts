#!/bin/bash

while [[ $(dropbox status) == "Starting..." ]] ; do
    if [[ $(dropbox status) == "Starting..." ]] ; then
        echo -ne "Dropbox hasn't woken up yet.\r"
        sleep 5
    elif [[ $(dropbox status | grep Indexing) == "Indexing..." ]] ; then
        echo -ne "Dropbox is making a todo list.\r"
        sleep 5
    elif [[ $(dropbox status | grep Syncing) ]] ; then
        echo -ne "Dropbox is actually syncing (finally).\r"
        sleep 5
    else
        echo "IT'S DONE!!!!"
    fi
done
