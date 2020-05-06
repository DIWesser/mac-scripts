#!/bin/bash

# This script adds snippets to my files of random notes

timeZone="America/Halifax"
creationDate="$(env TZ=$timeZone date +'%Y-%m-%d %Z')"
noteDir="$HOME/Dropbox/Notes/"
noteFile="$noteDir/Stray Words.md"
tmpfile="$(mktemp)"

appendWordsToNote() {
    echo "" >> "$noteFile"
    echo "**$creationDate:**  " >> "$noteFile"
    cat "$tmpfile" >> "$noteFile"
}

main() {
    $EDITOR "$tmpfile" # Get words in temp file
    appendWordsToNote
    rm "$tmpfile" # Remove temp file of words
    ranger "$noteDir"
}
main
