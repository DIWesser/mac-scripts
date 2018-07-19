#!/bin/bash

# Script for creating and streaming a randomly made up disposable playlist
# from youtube.
#
# Usage:
#   otf-play -a/--add <url>      # Add song to end of playlist
#   otf-play -n/--next <url>     # Add as next song
#   otf-play -p/--play           # Start playlist
#   otf-play -c/--clear          # clear playlist
#   otf-play -q/--queue          # Print title of songs in queue
#
# Todo:
#   - If no flags given, treat as -p/--play

programName="otf-play"
playlist="$HOME/.config/diwesser/otf-playlist"

play=false
topOfList=false
clearPlaylist=false
nextSong="null"
printHelp=false
listTitles=false

# Get options
while :; do
    case $1 in
        -h|-\?|--help) printHelp=true ;;
        -a|--add) newSong="$2" && topOfList=false ;;
        -c|--clear) clearPlaylist=true ;;
        -n|--next) newSong="$2" && topOfList=true ;;
        -p|--play) play=true ;;
        -q|--queue) listTitles=true ;;
        --) ;;
        -?*) echo "Invalid option: $1" ;;
        *)
            break
    esac
    shift
done

# -n|--next
# Add song to top of playlist
if [[ $newSong && $topOfList == true ]] ; then
    echo "$(echo "$newSong" | cat - $playlist)" > $playlist

# -a|--add
# Add song to end of playlist
elif [[ $newSong && $topOfList == false ]] ; then
    echo "$newSong" >> $playlist

# -p|--play
# Play song
elif [[ $play == true ]] ; then
    while [[ $(cat $playlist) ]] ; do       # While lines in playlist
        nextSong="$(head -n 1 $playlist)"   # Get url of next song
        # Remove next song from playlist
        tail -n +2 "$playlist" > "$playlist.tmp" && mv "$playlist.tmp" "$playlist"
        mpv --vid=no $nextSong              # And play it
    done
    echo "No songs in playlist"

# -c|--clear
# Clear playlist
elif [[ $clearPlaylist == true ]] ; then
    rm $playlist
    touch $playlist

# -q|--queue
# Print the titles of the songs
elif [[ $listTitles == true ]] ; then
    while read nextInCue; do
        youtube-dl --get-title $nextInCue
    done < $playlist

# -h|-\?|--help
# Print help text
elif [[ $printHelp == true ]] ; then
    echo "On The Fly PLAYlist is a script for making"
    echo "disposable Youtube playlists."
    echo ""
    echo " -a|--add <url>    # Add song to end of playlist"
    echo " -n|--next <url>   # Add as next song"
    echo " -p|--play         # Start playlist"
    echo " -q|--queue        # Print cued titles in order"
    echo " -c|--clear        # Clear playlist"
fi
