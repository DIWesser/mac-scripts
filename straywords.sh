#!/bin/bash

# This script adds snippets to my files of random notes

timeZone="America/Halifax"
creationDate="$(env TZ=$timeZone date +'%Y-%m-%d %Z')"
noteDir="$HOME/Dropbox/Notes/"
noteFile="$noteDir/Stray Words.md"
tmpfile="$(mktemp)"

add_words_to_note() {
    printf "\n**$creationDate:**  " >> "$noteFile"
    cat "$tmpfile" >> "$noteFile"
}

main() {
    $EDITOR "$tmpfile" # Get words in temp file
    add_words_to_note
    rm "$tmpfile" # Remove temp file of words
    ranger "$noteDir"
}
main
