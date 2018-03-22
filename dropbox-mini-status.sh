#!/bin/bash
#
# This script monitors for when Dropbox has finished syncing.

# If Dropbox is just starting up
if [[ $(dropbox status) == "Starting..." ]] ; then
    echo "❐    "
# If Dropbox is indexing
elif [[ $(dropbox status | grep Indexing) == "Indexing..." ]] ; then
    echo "❐ ..."
# If Dropbox is syncing
elif [[ $(dropbox status | grep Syncing | cut -d' ' -f 1) == "Syncing" ]] ; then
    echo ❐ $(dropbox status | grep "Syncing" | cut -d'(' -f2 | cut -d' ' -f1)
    #echo "⇵ ↻"
elif [[ $(dropbox status) == "Up to date" ]] ; then
    echo "❐ ✓"
else
    echo "❐ !!!"
fi
