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
courseFound=false
creationDate="$(env TZ=$timeZone date +'%Y-%m-%d')"
course=""
lecturer=""
title=""
termRoot="$HOME/Dropbox/Education/H. 2018-2019 Kings III Term 2"
noteFolder=""
noteFileName="$creationDate $title.md"
notePath=""
author="Daniel Wesser"


# Requires: timezone
# Takes no input, sets $course, $lecturer, and $noteFolder
# Determines course and lecturer based on hard-coded schedule
findCourse() {
    local dayOfWeek=$(env TZ=$timeZone date +'%A')
    local currentTime=$(env TZ=$timeZone date +'%H%M')
    if [[ "$dayOfWeek" == "Monday" ]] ; then
        if [[ "$currentTime" > "1015" && "$currentTime" < "1225" ]] ; then
            courseFound=true
            course="CTMP 3000"
            lecturer="Gordon McOuat"
        elif [[ "$currentTime" > "1515" && "$currentTime" < "1655" ]] ; then
            courseFound=true
            course="CSCI 3101"
            lecturer="Darren Abramson"
        fi
    elif [[ "$dayOfWeek" == "Tuesday" ]] ; then
        if [[ "$currentTime" > "1245" && "$currentTime" < "1425" ]] ; then
            courseFound=true
            course="PHIL 2020"
            lecturer="Greg Scherkoske"
        fi
    elif [[ "$dayOfWeek" == "Wednesday" ]] ; then
        if [[ "$currentTime" > "1015" && "$currentTime" < "1125" ]] ; then
            courseFound=true
            course="CTMP 3000"
        elif [[ "$currentTime" > "1515" && "$currentTime" < "1655" ]] ; then
            courseFound=true
            course="CSCI 3101"
            lecturer="Darren Abramson"
        fi
    elif [[ "$dayOfWeek" == "Thursday" ]] ; then
        if [[ "$currentTime" > "1245" && "$currentTime" < "1425" ]] ; then
            courseFound=true
            course="PHIL 2020"
            lecturer="Greg Scherkoske"
        fi
    elif [[ "$dayOfWeek" == "Friday" ]] ; then
        if [[ "$currentTime" > "1715" && "$currentTime" < "2025" ]] ; then
            courseFound=true
            course="CTMP 2203"
            lecturer="Michael Bennett"
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


# Main
main() {
    # Find out what the course and lecturer are
    findCourse

    # If no course is detected, stop.
    if [[ $courseFound == false ]] ; then
        echo "You do not have any classes scheduled at this time."
        exit 1
    fi

    # Ask user what title they want to give the note
    getTitle

    # Create file
    touch "$notePath"

    # Fill in file header and title
    createHeader
    appendTitle

    # Open file
    $EDITOR "$notePath"
}

main
