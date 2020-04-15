#!/bin/bash
# This script is used to create and update local archives of Youtube channels

# Todo:
# - Option flag for archive_dir.
# - Transcode to HEVC (hint: `youtbe-dl --exec`).
# - Option to only update a specific channel.
# - Confirm folder name when adding new channel.
# - Allow for per channel config file (e.g. parsing consistantly formatted
#   channel titles to extract actual video title).
# - Confirm dir has a channel_url file.

archive_dir="/run/media/daniel/DIW Storage 0/video/youtube channels"
alias printf='builtin printf'

# Takes url, returns channel directory name or empty string.
# The 'channel_url' file exists test is hack to deal with empty input. It should
# be replaced with input validation.
function is_subbed_test () {
    for i in "$archive_dir"/* ; do
        if [[ -f "$i"/channel_url && $(cat "$i"/channel_url) == "$1" ]] ; then
            printf "${i##*/}"
            exit 1
        fi
    done
    printf ""
}

function new_sub () {
    local url=""
    local channel=""
    printf "Enter channel URL: "
    read url
    local existing_dir=$(is_subbed_test "$url")
    if [[ "$existing_dir" != "" ]] ; then
        printf "This channel is already being saved to \'$existing_dir\'.\n"
    else
        channel="$(youtube-dl --get-filename --playlist-end 1 --output '%(uploader)s' $url)"
        mkdir "$archive_dir"/"$channel"
        printf "$url" > "$archive_dir"/"$channel"/channel_url
        printf "Channel added. Videos will be saved to \'$channel\'.\n"
    fi
}

function download () {
    youtube-dl \
        --download-archive downloaded \
        --continue \
        --ignore-errors \
        --no-overwrites \
        --add-metadata \
        --write-thumbnail \
        --embed-thumbnail \
        --all-subs \
        --embed-subs \
        --write-info-json \
        --output "%(upload_date)s %(title)s [Video ID: %(id)s].%(ext)s" \
        "$1"
}

function update_all_channels () {
    for i in "$archive_dir"/*; do
        cd "$i"
        download "$(cat channel_url)"
    done
}

function main () {
    if [[ "$1" == "update" ]] ; then
        update_all_channels
    elif [[ "$1" == "add" ]] ; then
        new_sub
    else
        printf "Command not recognized. Recognized commands are 'update' and "
        printf "'add'\n"
    fi
}

main "$@"
