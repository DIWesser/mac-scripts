#! /bin/bash

# This script maintains a lossly clone of a music directory.
# It creates a list of new or updated files, creates a lossy copy, and saves
# that copy to a lossy directory with the same path.
# 
# The script assumes that the music directories are structured as follows:
# <(flac|mp3) root>/<artist>/<album>/<track.(flac|mp3)>
# and the file and directory names do not contain `/`.

losslessRoot="$HOME/Desktop/Music"
lossyRoot="$HOME/Desktop/MP3"

# Finds track from full file path
find_track () {
    fullPath="$@"
    trackFile="${fullPath##*/}"
    track="${trackFile%.*}"
    echo "track is: $track"
}

# Finds album from full file path
find_album () {
    fullPath="$@"
    albumPath="${fullPath%/*}"
    album="${albumPath##*/}"
    echo "Album is: $album"
}

# Finds artist from full file path
find_artist () {
    fullPath="$@"
    albumPath="${fullPath%/*}"
    artistPath="${albumPath%/*}"
    artist="${artistPath##*/}"
    echo "Artist is: $artist"
}

# Takes full file path and root as argument. Returns artist/album/track
between_root_and_ext () {
    fullPath="$1"
    rootPath="$2"
    noRootWithExt="${fullPath#"$rootPath"}"
    noRootOrExt="${noRootWithExt%.*}"
    echo "$noRootOrExt"
}

# Takes partial file path between root and extension
convert_to_mp3 () {
    ffmpeg -i "$losslessRoot/$@.flac" "$lossyRoot/$@.mp3"
}

################################################################################
# Mainly exists for inpiration. Do not use.
################################################################################

# Takes directory as argument
convert_dir_wav_flac () {
    tmp="$(pwd)"
    cd "$1"
    for i in *.wav; do ffmpeg -i "$i" "${i%.*}.flac"; done && rm *.wav
    cd "$tmp"
}

#parallel ffmpeg -i ::: *.flac
