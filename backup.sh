#!/bin/bash

#################################################################################
# Global Variables
#################################################################################
#sourceDir="$HOME/Desktop/Source/"
#destDir="$HOME/Desktop/Destination/"
sourceDir="/"
destDir="/Volumes/DIW Boot 1/"
archiveRoot="_CCC SafetyNet"
archiveDir="$archiveRoot/$(date +%Y-%m-%d\ \(%B\ %d\)\ %H-%M-%S)"

if [ ! -r "$sourceDir" ]; then
    echo "Source $sourceDir not readable - Cannot start the sync process"
    exit;
fi

if [ ! -w "$destDir" ]; then
    "Destination $destDir not writeable - Cannot start the sync process"
    exit;
fi

#################################################################################
# OS Variables
#################################################################################
if [[ $(uname -s) == Darwin ]] ; then
    os="macOS"
    exclude="$HOME/.config/diwesser/backup-exclude-mac"
fi

rsync \
    --archive \
    --backup \
    --backup-dir="$archiveDir" \
    --exclude-from="$exclude" \
    --verbose \
    --stats \
    --progress \
    "$sourceDir" \
    "$destDir" 
    #--dry-run
