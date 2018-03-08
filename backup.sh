#!/bin/bash

sourceDir="Source/"
destDir="Destination/"
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
