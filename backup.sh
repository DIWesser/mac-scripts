#!/bin/bash

#################################################################################
# Global Variables
#################################################################################
#sourceDir="$HOME/Desktop/Source/"
#destDir="$HOME/Desktop/Destination/"
sourceDir="/"
destDir="/Volumes/Boot 1"
archiveRoot="_CCC"
archiveDir="$archiveRoot/$(date +%Y-%m-%d\ \(%B\ %d\)\ %H-%M-%S)"

#################################################################################
# OS Variables
#################################################################################
if [[ $(uname -s) == Darwin ]] ; then
    os="macOS"
    exclude=".config/diwesser/backup-exclude-mac"
fi

rsync \
    --archive \
    --verbose \
    --backup \
    --backup-dir="$archiveDir" \
    --exclude-from="$exclude" \
    --stats \
    --progress \
    "$sourceDir" \
    "$destDir" \
    --dry-run
