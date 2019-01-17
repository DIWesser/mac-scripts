#!/bin/bash

# This script is designed to mimic the function of SelfControl.app, a macOS app
# for blocking destracting websites for an arbitrary period of time.
#
# Todo:
# - Automatically remove expired block (Is this just a deamon in bash?)
# - Add ability to add to distracting url list
# - Update distracting url list if change made while block is in place
# - Add support for swiching between lists or merging lists
# - Consistent function names (this would be halfway to a rewrite)
#
# Possibly move to function:
# - Wiping block end time
# - Finding block end time
# - Finding block end time but pretty (this is a real mess and the source of all
#   shellcheck violations at the moment)
#
# Current obvious security problems:
# - Temporarily stores /etc/hosts in user space

configDirectory="$HOME/.config/diwesser"
statusFile="$configDirectory/linux_control_status"
endBlockTimeFile="$configDirectory/linux_control_block_end"


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
    local minutes="$1"
    local seconds="$(echo "$minutes * 60" | bc -ql)"
    local now="$(date +'%s')"
    echo -n "$(echo "$now + $seconds" | bc -ql)"
}


# Check if block has expired.
# Returns true if it has expired, false if not
block_has_expired () {
    local endTime="$(tail -n 1 "$endBlockTimeFile")"
    local now="$(date +'%s')"

    if [[ "$now" < "$endTime" ]] ; then
        false
    else
        true
    fi
}


# Writes block expiration in epoc time
# Assumes block starts now
# Takes block time in minutes
set_block_expiration () {
    epoc_now_plus_min "$1" > "$endBlockTimeFile"
}


# Checks for block expiration and remove if expired
remove_block_if_expired () {
    if [[ $(block_has_expired) == true ]] ; then
        restore_original_hosts
        echo "" > "$endBlockTimeFile" # Wipe block time
        echo "Expired block removed"
    else
        echo "Block has not expired"
    fi
}


# Starts block and sets time for it to expire
# Takes block length in minutes
start_block_with_expiration () {
    if [[ $(date +'%s') < $(tail -n1 $endBlockTimeFile) && check_if_blocked ]] ; then
        echo "Block is in place and has not expired"
    else
        set_block_expiration "$1"
        set_blocked_hosts
    fi
    echo "Block will expire at $(date -d @$(tail -n1 $endBlockTimeFile) \
        +'%A at %I:%M %P')"
    # Date formatted as "[day of week] at [HH]:[MM] [am/pm]"
}


main () {
    local functionName="main"

    if [[ "$1" == "start" ]] ; then
        if [[ -z "$2" ]] ; then
            echo "Block time in minutes is needed."
            echo "For an indefinite block, use 'endless'."
        else
            echo "Setting block"
            start_block_with_expiration "$2"
        fi

    elif [[ "$1" == "endless" ]] ; then
        echo "Setting block"
        set_blocked_hosts
        echo "" > "$endBlockTimeFile" # Wipe block time
    elif [[ "$1" == "end" ]] ; then
        remove_block_if_expired

    elif [[ "$1" == "purge" ]] ; then
        echo "Removing block"
        restore_original_hosts
        echo "" > "$endBlockTimeFile" # Wipe block time
        echo "Block time wiped"

    elif [[ "$1" == "status" ]] ; then
        if check_if_blocked ; then
            echo "Block is enabled and will expire at $(date -d \
                  @$(tail -n1 $endBlockTimeFile) \
                  +'%A at %I:%M %P')"
        else
            echo "Block is not enabled"
        fi

    elif [[ "$1" == "help" ]] ; then
        echo "The following commands are accepted:"
        echo "  start --- Starts block. Requires duration in minutes."
        echo "  endless - Starts block without end"
        echo "  end ----- Ends expired blocks."
        echo "  purge --- Ends all blocks. Overrides timer."
        echo "  status -- Prints block status."
    else
        echo "Error from '$functionName': Unrecognized command."
    fi
}

main "$@"
