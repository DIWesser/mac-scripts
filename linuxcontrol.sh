#!/bin/bash

# This script is designed to mimic the function of SelfControl.app, a macOS app
# for blocking destracting websites for an arbitrary period of time.
#
# Todo:
# - Add timed blocking
# - Add ability to add to distracting url list
# - Update distracting url list if change made while block is in place
# - Impliment flags for different modes of operation (e.g. blocking, unblocking)
# - Add support for swiching between lists or merging lists

configDirectory="$HOME/.config/diwesser"


# Set /etc/hosts to controlled state.
set_controlled_hosts () {
    
    # Backup current /etc/hosts
    cp /etc/hosts "$configDirectory/original_hosts_file"

    # Append blocked url rules to /etc/hosts
    convert_urls_to_hosts >> /etc/hosts
}


# Restore /etc/hosts to original uncontrolled state.
restore_original_hosts () {
    
    # Copy backup of original hosts file to /etc/hosts
    cp "$configDirectory/original_hosts_file" "/etc/hosts"
}


# Takes plain list of urls and outputs them as host rules.
# Output of this function is intended to be piped to /etc/hosts to start
# controlled state.
convert_urls_to_hosts () {
    while read -r i; do
        echo "0.0.0.0 $i" # IPv4 rule
        echo "::0 $i"     # IPv6 rule
    done <"$configDirectory/distracting_urls"
}


set_controlled_hosts

#restore_original_hosts
