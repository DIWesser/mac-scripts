#!/bin/bash

sourceDir="$HOME/Desktop/Source/"
destDir="$HOME/Desktop/Destination/"
archiveFolder="_CCC"

rsync \
    --archive \
    --verbose \
    --backup \
    --backup-dir="$archiveFolder" \
    --exclude=/Volumes/ \
    --stats \
    --progress \
    "$sourceDir" \
    "$destDir"
