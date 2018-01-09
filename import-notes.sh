#!/bin/bash

# Define source based on OS
if [[ $(uname -s) == Darwin ]] ; then
    sourceDir="/Volumes/TO GO"
elif [[ $(uname -s) == Linux ]] ; then
    sourceDir="/media/$(whoami)/TO GO"
fi

# Define destination path
destDir="$HOME/Dropbox/Education/F. 2017-2018 Kings II Term 2"

# If source path is usable
if [ -d "$sourceDir" ] ; then

    # While there are notes files at the source
    while [[ $(ls "$sourceDir" | grep -E "JOUR 2701.md|CSCI 1101.md") ]] ; do
        file=$(ls "$sourceDir" | grep -E "JOUR 2701.md|CSCI 1101.md" | head -1)

        # Change destination based on class
        if [[ $file == *JOUR\ 2701.md ]] ; then
            subDestDir="JOUR 2701/Notes"
        elif [[ $file == *CSCI\ 1101.md ]] ; then
            subDestDir="CSCI 1101/Notes"
        fi

        # Find out what title to use for notes
        echo "What title do you want to give $file?"
        read className

        # Move notes
        fileDate=$(echo "$file" | cut -d" " -f1)
        cp "$sourceDir/$file" "$destDir/$subDestDir/$fileDate $className.md" \
            && rm "$sourceDir/$file"
    done
else
    echo "\"$sourceDir\" was not found"
fi
