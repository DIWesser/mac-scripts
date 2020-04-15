#!/bin/bash
# This script is used to create and update local archives of Youtube channels

# Todo:
# - Option flag for archive_dir.
# - Transcode to HEVC (hint: `--exec`).
# - Option to only update a specific channel.
# - Option to add a channel with this script.
# - Allow for per channel config file (e.g. parsing consistantly formatted
#   channel titles to extract actual video title).
# - Use the source name from the download archive file instead of the hardcoded
#   'Youtube ID:' in the [Youtube ID: 123xyz] tag.

archive_dir="/run/media/daniel/DIW Storage 0/video/youtube channels"

new_subscription () {
    local url=""
    local channel=""
    echo -ne "Enter channel URL: "
    read "url"
    channel="$(youtube-dl --get-filename --playlist-end 1 --output '%(uploader)s' $url)"
    mkdir "$archive_dir"/"$channel"
    echo "$channel_url" > "$archive_dir"/"$channel"/channel_url
}

download () {
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
        --output "%(upload_date)s %(title)s [Youtube ID: %(id)s].%(ext)s" \
        "$1"
}

update_all_channels () {
    for i in "$archive_dir"/*; do
        cd "$i"
        download "$(cat channel_url)"
    done
}

update_all_channels
