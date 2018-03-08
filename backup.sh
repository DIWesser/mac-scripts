#!/bin/bash
# Know Problems
#   - Archive size is ound using df -H. This may cause problems if the free space
#     in the archive is over 1TB

#################################################################################
# Global Variables
#################################################################################
#sourceDir="$HOME/Desktop/Source/"
#destDir="$HOME/Desktop/Destination/"
sourceDir="/"
destDir="/Volumes/DIW Boot 1/"
archiveRoot="_CCC SafetyNet"
archiveDir="$archiveRoot/$(date +%Y-%m-%d\ \(%B\ $(date +%e | xargs)\)\ %H-%M-%S)"
pruneValue=150  # Minimum archive size in GB

#################################################################################
# OS Variables
#################################################################################
if [[ $(uname -s) == Darwin ]] ; then
    os="macOS"
    exclude="$HOME/.config/diwesser/backup-exclude-mac"
fi

#################################################################################
# Pre-Run Operations
#################################################################################
# Check for source directory
if [ ! -r "$sourceDir" ]; then
    echo "Source $sourceDir not readable - Cannot start the sync process"
    exit;
fi

# Check for backup directory
if [ ! -w "$destDir" ]; then
    echo "Destination $destDir not writeable - Cannot start the sync process"
    exit;
fi

# Check archive size
if [[ $(df -PH . | tail -1 | awk '{print $4}' | cut -d'G' -f1) -lt $pruneValue ]] ; then
    echo "Warning! Archive is under $pruneValue GB"
fi

#################################################################################
# Run
#################################################################################
rsync \
    --archive \
    --backup \
    --delete-after \
    --backup-dir="$archiveDir" \
    --exclude-from="$exclude" \
    --verbose \
    --stats \
    --progress \
    "$sourceDir" \
    "$destDir" 
    #--dry-run
