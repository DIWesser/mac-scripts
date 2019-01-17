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
statusFile="$configDirectory/linux_control_status"


# Set /etc/hosts to blocked state.
set_blocked_hosts () {

    if check_if_blocked ; then
        echo "Block is already in place"
    else
    
        # Backup current /etc/hosts
        cp /etc/hosts "$configDirectory/original_hosts_file"

        # Append blocked url rules to /etc/hosts
        convert_urls_to_hosts >> /etc/hosts
        
        set_block_status blocked

        echo "Block set"
    fi
}


# Restore /etc/hosts to original unblocked state.
restore_original_hosts () {
    
    # Copy backup of original hosts file to /etc/hosts
    cp "$configDirectory/original_hosts_file" "/etc/hosts"

    set_block_status unblocked

    echo "Block removed"
}


# Takes plain list of urls and outputs them as host rules.
# Output of this function is intended to be piped to /etc/hosts to start
# blocked state.
convert_urls_to_hosts () {
    while read -r i; do
        echo "0.0.0.0 $i" # IPv4 rule
        echo "::0 $i"     # IPv6 rule
    done <"$configDirectory/distracting_urls"
}


# Checks if block is enabled.
# Returns true of false boolean
check_if_blocked () {
    if grep -q -x "blocked" "$statusFile"; then
        true
    elif grep -q -x "unblocked" "$statusFile"; then
        false
    fi
}


# Sets blocked status
# Takes input as either "blocked" or "unblocked"
set_block_status () {
    if [[ "$1" == "blocked" ]] ; then
        echo "blocked" > "$statusFile"
    elif [[ "$1" == "unblocked" ]] ; then
        echo "unblocked" > "$statusFile"
    fi
}


# Takes a number of minutes and adds them to current epoc as seconds
# Returns epoc.
epoc_now_plus_min () {
    local minutes=$1
    local seconds=$(echo "$minutes * 60" | bc -ql)
    local now=$(date +'%s')
    echo -n $(echo "$now + $seconds" | bc -ql)
}


check_block_expirations () {
    linux_control_scheduled_end
}


main () {
    local functionName="main"

    if [[ "$1" == "start" ]] ; then
        echo "Setting block"
        set_blocked_hosts
    elif [[ "$1" == "end" ]] ; then
        echo "Removing block"
        restore_original_hosts
    elif [[ "$1" == "status" ]] ; then
        if check_if_blocked ; then
            echo "Block is enabled"
        else
            echo "Block is not enabled"
        fi
    else
        echo "Error from '$functionName': Unrecognized command."
    fi
}

main "$@"
