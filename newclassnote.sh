#!/bin/bash

# This script creates school notes with the file name and file header pre-filled
# in the correct folder based on the date that the script is run.
# The file is then opened for editing.
#
# Assumes:
# - that the script is being run while sitting in class
# - that the notes are for said current class;
# - that you have my class schedule
#
# Ideas:
# - Maybe check if there is already a note for current course
# - make it possible to specify course, lecturer, etc. when calling the script


timeZone="America/Halifax"
creationDate="$(env TZ=$timeZone date +'%Y-%m-%d')"
course=""
lecturer=""
title=""
termRoot="$HOME/Dropbox/Education/G. 2018-2019 Kings III Term 1"
noteFolder=""
noteFileName="$creationDate $title.md"
notePath=""
author="Daniel Wesser"


################################################################################
# Functions
################################################################################

# Requires: timezone
# Takes no input, sets $course, $lecturer, and $noteFolder
# Determines course and lecturer based on hard-coded schedule
findCourse() {
    local dayOfWeek=$(env TZ=$timeZone date +'%A')
    local currentTime=$(env TZ=$timeZone date +'%H%M')
    if [[ "$dayOfWeek" == "Monday" ]] ; then
        if [[ "$currentTime" > "1015" && "$currentTime" < "1225" ]] ; then
            course="CTMP 3000"
            lecturer="Gordon McOuat"
        elif [[ "$currentTime" > "1315" && "$currentTime" < "1425" ]] ; then
            course="PHIL 2475"
            lecturer="Stephanie Kapusta"
        fi
    elif [[ "$dayOfWeek" == "Tuesday" ]] ; then
        if [[ "$currentTime" > "1015" && "$currentTime" < "1125" ]] ; then
            course="CTMP 3121"
            lecturer="Dorota Glowacka"
        elif [[ "$currentTime" > "1615" && "$currentTime" < "1755" ]] ; then
            course="LAWS 2510"
            lecturer="Dale Darling"
        fi
    elif [[ "$dayOfWeek" == "Wednesday" ]] ; then
        if [[ "$currentTime" > "1015" && "$currentTime" < "1125" ]] ; then
            course="CTMP 3000"
        elif [[ "$currentTime" > "1315" && "$currentTime" < "1425" ]] ; then
            course="PHIL 2475"
            lecturer="Stephanie Kapusta"
        fi
    elif [[ "$dayOfWeek" == "Thursday" ]] ; then
        if [[ "$currentTime" > "0915" && "$currentTime" < "1025" ]] ; then
            course="CTMP 3121"
        elif [[ "$currentTime" > "1615" && "$currentTime" < "1755" ]] ; then
            course="LAWS 2510"
            lecturer="Dale Darling"
        fi
    elif [[ "$dayOfWeek" == "Friday" ]] ; then
        if [[ "$currentTime" > "1315" && "$currentTime" < "1425" ]] ; then
            course="PHIL 2475"
            lecturer="Stephanie Kapusta"
        fi
    fi

    # Update note folder with new course name
    noteFolder="$termRoot/$course/Notes"
}


# Requires: $course, $creationDate, and $noteFolder
# Asks user for title
# Sets: $title, $noteFileName, $notePath
getTitle() {
    # Ask for title
    echo "What title do you want to give today's '$course' note?"
    read "title"

    # Update file name and path
    noteFileName="$creationDate $title.md"
    notePath="$noteFolder/$noteFileName"
}


# A function to fill in the header once all variable are set
# Requires: notePath (therefor title)
createHeader() {
    echo "---" >> "$notePath"
    echo "created: $creationDate" >> "$notePath"
    echo "course: $course" >> "$notePath"
    echo "lecturer: $lecturer" >> "$notePath"
    echo "author: $author" >> "$notePath"
    echo "---" >> "$notePath"
}


# This function adds a title following a header. It should only be run on a file
# that already has a YAML header block.
# Requires: $notePath, $title
appendTitle() {
    echo "" >> "$notePath"
    echo "## $title" >> "$notePath"
    echo "" >> "$notePath"
}

################################################################################
# Main
################################################################################

# Find out what the course and lecturer are
findCourse

# Ask user what title they want to give the note
getTitle

# Create file
touch "$notePath"

# Fill in file header and title
createHeader
appendTitle

# Open file
$EDITOR "$notePath" &
