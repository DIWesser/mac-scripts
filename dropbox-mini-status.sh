#!/bin/bash
#
# This script monitors for when Dropbox has finished syncing.
#
# Todo:
# - This script calls `dropbox status` too many times. It should call it once.

# If Dropbox is up to date
if [[ $(dropbox status) == "Up to date" ]] ; then
    echo "❐ ✓"
# If Dropbox is just starting up
elif [[ $(dropbox status) == "Starting..." ]] ; then
    echo "❐ starting"
# If Dropbox is indexing
elif [[ $(dropbox status | grep "Indexing...") ]] ; then
    echo "❐ indexing"
# If Dropbox is syncing
elif [[ $(dropbox status | grep Syncing | cut -d' ' -f 1) ]] ; then
    echo ❐ $(dropbox status | grep "Syncing" | cut -d'(' -f2 | cut -d' ' -f1)
    #echo "⇵ ↻"
else
    echo "❐ !!!"
fi
