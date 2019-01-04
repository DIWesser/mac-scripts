#!/bin/bash
# A script to find what operating system the script is running in.

# Trims leading and trailing white space from a string.
# Takes string, returns trimmed version of string.
# Stolen from https://stackoverflow.com/a/3352015
trimWhitespace() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"
    echo -n "$var"
}


# Finds what kernel the machine is running.
# Takes no input, returns kernel name as string.
findKernel() {
    local possible_kernel="$(uname -s)"
    echo -n "$possible_kernel"
}


# Finds the distrobution of the kernel
# Takes kernel as string
# Returns distro name as string.
findDistro() {
    local given_kernel="$*"
    local possible_distro=""
    if [[ "$given_kernel" == "Linux" ]] ; then
        possible_distro=$(lsb_release --id | cut -d ':' -f 2)
        possible_distro="$(trimWhitespace $possible_distro)"
    elif [[ "$given_kernel" == "Darwin" ]] ; then
        possible_distro="macOS"
    fi
    echo -n "$possible_distro"
}


# Finds version of operating system
# Takes distro, returns distro version as a string.
findVersion() {
    local possible_distro="$*"
    local possible_version=""
    if [[ "$possible_distro" == "Ubuntu" ]] ; then
        possible_version="$(lsb_release --description | cut -d ':' -f 2 \
            | cut -d 'u' -f 3)"
        possible_version="$(trimWhitespace $possible_version)"
    fi
    echo -n "$possible_version"
}

main() {
    osKernel="$(findKernel)"
    osDistro="$(findDistro "$osKernel")"
    osVersion="$(findVersion "$osDistro")"

    echo "$osKernel"
    echo "$osDistro"
    echo "$osVersion"
}

main
