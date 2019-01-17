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

    if check_if_controlled ; then
        echo "Block is already in place"
    else
    
        # Backup current /etc/hosts
        cp /etc/hosts "$configDirectory/original_hosts_file"

        # Append blocked url rules to /etc/hosts
        convert_urls_to_hosts >> /etc/hosts
        
        set_control_status controlled

        echo "Block set"
    fi
}


# Restore /etc/hosts to original uncontrolled state.
restore_original_hosts () {
    
    # Copy backup of original hosts file to /etc/hosts
    cp "$configDirectory/original_hosts_file" "/etc/hosts"

    set_control_status uncontrolled

    echo "Block removed"
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


# Checks if control is enabled.
# Returns true of false boolean
check_if_controlled () {
    if grep -q -x "controlled" "$configDirectory/linux_control_status"; then
        true
    elif grep -q -x "uncontrolled" "$configDirectory/linux_control_status"; then
        false
    fi
}


# Sets controlled status
# Takes input as either "controlled" or "uncontrolled"
set_control_status () {
    if [[ "$1" == "controlled" ]] ; then
        echo "controlled" > "$configDirectory/linux_control_status"
    elif [[ "$1" == "uncontrolled" ]] ; then
        echo "uncontrolled" > "$configDirectory/linux_control_status"
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


main () {
    local functionName="main"

    if [[ "$1" == "start" ]] ; then
        echo "Setting block"
        set_controlled_hosts
    elif [[ "$1" == "end" ]] ; then
        echo "Removing block"
        restore_original_hosts
    elif [[ "$1" == "status" ]] ; then
        if check_if_controlled ; then
            echo "Block is enabled"
        else
            echo "Block is not enabled"
        fi
    else
        echo "Error from '$functionName': Unrecognized command."
    fi
}

main "$@"
