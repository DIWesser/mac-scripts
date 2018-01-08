#!/bin/bash

sourceDir="/Volumes/TO GO"
destDir="$HOME/Dropbox/Education/F. 2017-2018 Kings II Term 2"

if [ -d "$sourceDir" ] ; then
    while [[ $(ls "$sourceDir" | grep -E "JOUR 2701.md|CSCI 1101.md") ]] ; do
        file=$(ls "$sourceDir" | grep -E "JOUR 2701.md|CSCI 1101.md" | head -1)
        if [[ $file == *JOUR\ 2701.md ]] ; then
            subDestDir="JOUR 2701/Notes"
        elif [[ $file == *CSCI\ 1101.md ]] ; then
            subDestDir="CSCI 1101/Notes"
        fi

        echo "What title do you want to give $file?"
        read className

        fileDate=$(echo "$file" | cut -d" " -f1)
        cp "$sourceDir/$file" "$destDir/$subDestDir/$fileDate $className.md" \
            && rm "$sourceDir/$file"
    done
else
    echo "\"$sourceDir\" was not found"
fi
