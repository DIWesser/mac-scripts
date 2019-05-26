#! /bin/bash

# This script maintains a lossly clone of a music directory.
# It creates a list of new or updated files, creates a lossy copy, and saves
# that copy to a lossy directory with the same path.

losslessDir=""
lossyDir=""

convert () {
    ffmpeg -i "$1" "$1.mp3"
}

# Takes directory as argument
convert_dir_wav_flac () {
    tmp="$(pwd)"
    cd "$1"
    for i in *.wav; do ffmpeg -i "$i" "${i%.*}.flac"; done && rm *.wav
    cd "$tmp"
}

#parallel ffmpeg -i ::: *.flac
