#!/bin/bash

# Basic Technique (https://en.wikipedia.org/wiki/Pomodoro_Technique)

# 1. Decide on the task to be done.
# 2. Set the pomodoro timer (traditionally to 25 minutes).
# 3. Work on the task.
# 4. End work when the timer rings and put a checkmark on a piece of paper.
# 5. If you have fewer than four checkmarks, take a short break (3–5 minutes),
#    then go to step 2.
# 6. After four pomodoros, take a longer break (15–30 minutes), reset your
#    checkmark count to zero, then go to step 1.

# Todo:
#
# - Add support for festival, flight, and/or mimic TTS

################################################################################
# Create settings variables
################################################################################

appName=Pomodoro
settings=$HOME/.config/diwesser/pomodoro.conf

# grep line for variable. Extracts everything between first and second ':'
# Trims whitspace from both ends.
# Regex matches start of line excluding whitespace.
# Times are returned in seconds
shortBreak=$(grep -iw '^\s*short break:' $settings | cut -d: -f2 | xargs)
longBreak=$(grep -iw '^\s*long break:' $settings | cut -d: -f2 | xargs)
workPeriod=$(grep -iw '^\s*work period:' $settings | cut -d: -f2 | xargs)
togglApiToken=$(grep -iw '^\s*toggl api token:' $settings | cut -d: -f2 | xargs)

################################################################################
# Functions
################################################################################

function textToSpeech {
    if [[ $(uname -s) == Darwin ]] ; then
        say $1
    elif [[ $(uname -s) == Linux ]] ; then
        echo "Text to speech is not yet supported on Linux"
    else
        echo "Whatever you're running, text to speech doesn't work on it yet."
    fi
}

function sendNotification {
    if [[ $(uname -s) == Darwin ]] ; then
        osascript \
            -e "on run(argv)" \
            -e "return display notification item 1 of argv" \
            -e "end" \
            -- "$1"
    elif [[ $(command -v zenity) ]] ; then
        zenity --notification --text="$1"
    elif [[ $(uname -s) == Linux ]] ; then
        echo -ne "Notifications on Linux require zenity.\n"
    else
        echo -ne "Whatever you're running, notifications don't work on it yet."\
		 "If your OS has a version of zenity, try installing that.\n"
    fi
}

# THIS IS A SHIT SHOW RIGHT NOW. DON'T USE IT!!!!!!!!!!!
function timeTracking {
    # Start time tracking
    curl -sS -u $togglApiToken:api_token \
        -H "Content-Type: application/json" \
        -d '{"time_entry":{
            "description":"EMSP2390 Reading Response 2",
            "tags":["EMSP2390","writing"],
            "pid":88939415,
            "created_with":"curl"
        }}' \
        -X POST https://www.toggl.com/api/v8/time_entries/start

    # Start time tracking
    curl -sS -u $togglApiToken:api_token \
        -H "Content-Type: application/json" \
        -d '{"time_entry":{
            "description":"EMSP2390 Reading Response 2",
            "tags":["break"],
            "pid":88939415,
            "created_with":"curl"
        }}' \
        -X POST https://www.toggl.com/api/v8/time_entries/start

    # End time tracking
    # Find running time tracker
    runningTimeTracker=$(
        curl -sS -u $togglApiToken:api_token \
            -X GET https://www.toggl.com/api/v8/time_entries/current \
            | awk -F 'id' '{print $2}' | cut -d: -f2 | cut -d, -f1
    )
    # Kill it
    curl -v -u $togglApiToken:api_token \
    -H "Content-Type: application/json" \
    -X PUT https://www.toggl.com/api/v8/time_entries/$runningTimeTracker/stop

}

################################################################################
# Run timer
################################################################################

    ############################################################################
    # Work period
    ############################################################################
    sendNotification "Starting work timer.\nWork for 25 minutes"
    textToSpeech "Begin."


    sleep $workPeriod # Sleep 25 minutes
    echo

    ############################################################################
    # Break period
    ############################################################################
    sendNotification "Take a break"
    textToSpeech "Time to take a break."

    read -p "Press any key to start break" -n 1 -s
    echo

    sleep `expr $shortBreak - 60` # Take short break - 1 minute for warning
    sendNotification "Break ends in 1 minute"
    textToSpeech "One minute warning."
    sleep 60

    ############################################################################
    # End of break
    ############################################################################
    sendNotification "Break over."
    textToSpeech "Break period over."

    read -p "Press any key to end break" -n 1 -s
    echo
