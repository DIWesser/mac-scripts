#!/bin/bash
# This script is used to create and update local archives of Youtube channels

youtube_archive_dir="/run/media/daniel/DIW Storage 0/video/youtube channels"

#add_channel () {}
#update_single_channel () {}

download () {
    youtube-dl \
        --format best \
        --download-archive downloaded \
        --continue \
        --ignore-errors \
        --no-overwrites \
        --embed-thumbnail \
        --write-description \
        --write-info-json \
        --output "%(upload_date)s %(title)s [%(resolution)s] [Youtube ID: %(id)s].%(ext)s" \
        "$1"
}

update_all_channels () {
    for i in "$youtube_archive_dir"/*; do
        cd "$i"
        download "$(cat channel_url)"
    done
}

update_all_channels
