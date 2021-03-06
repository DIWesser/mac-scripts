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
# - Maybe check if there is already a note for current lecture.
# - Make it possible to specify course, lecturer, etc. when calling the script.


timeZone="America/Halifax"
courseFound=false
creationDate="$(env TZ=$timeZone date +'%Y-%m-%d')"
course=""
courseFolder=""
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
        if [[ "$currentTime" > "1020" && "$currentTime" < "1120" ]] ; then
            courseFound=true
            course="CTMP 3000"
            lecturer="Gordon McOuat"
        elif [[ "$currentTime" > "1120" && "$currentTime" < "1225" ]] ; then
            courseFound=true
            course="PHIL 2475"
            lecturer="Shaun Miller"
        elif [[ "$currentTime" > "1320" && "$currentTime" < "1525" ]] ; then
            courseFound=true
            course="CTMP 2000"
            lecturer="Sarah Clift"
        fi
    elif [[ "$dayOfWeek" == "Tuesday" ]] ; then
        if [[ "$currentTime" > "0950" && "$currentTime" < "1125" ]] ; then
            courseFound=true
            course="CTMP 3215"
            lecturer="Kathryn A. Morris"
        elif [[ "$currentTime" > "1550" && "$currentTime" < "1725" ]] ; then
            courseFound=true
            course="CTMP 2206"
            lecturer="Stephen R. Boos"
        fi
    elif [[ "$dayOfWeek" == "Wednesday" ]] ; then
        if [[ "$currentTime" > "1020" && "$currentTime" < "1125" ]] ; then
            courseFound=true
            course="CTMP 3000"
        elif [[ "$currentTime" > "1125" && "$currentTime" < "1225" ]] ; then
            courseFound=true
            course="PHIL 2475"
            lecturer="Shaun Miller"
        elif [[ "$currentTime" > "1320" && "$currentTime" < "1425" ]] ; then
            courseFound=true
            course="CTMP 2000"
        fi
    elif [[ "$dayOfWeek" == "Thursday" ]] ; then
        if [[ "$currentTime" > "0950" && "$currentTime" < "1125" ]] ; then
            courseFound=true
            course="CTMP 3215"
            lecturer="Kathryn A. Morris"
        elif [[ "$currentTime" > "1550" && "$currentTime" < "1725" ]] ; then
            courseFound=true
            course="CTMP 2206"
            lecturer="Stephen R. Boos"
        fi
    elif [[ "$dayOfWeek" == "Friday" ]] ; then
        if [[ "$currentTime" > "1120" && "$currentTime" < "1225" ]] ; then
            courseFound=true
            course="PHIL 2475"
            lecturer="Shaun Miller"
        fi
    fi
}


# Uses course code to find the full name of course folder. It is meant to
# handle course folder name when the full path includes the course title.
# Requires: $course, $termRoot
# Sets: $courseFolder
complete_course_folder() {
    # For all folders/files in term root
    for i in "$termRoot"; do
        # if first 9 characters of folder/file == course code
        if [[ "${i:0:9}" == "$course" ]] ; then
            courseFolder="$i"
            break
        fi
    done
}

# Requires: $course, $creationDate, and $noteFolder
# Asks user for title
# Sets: $title, $noteFileName, $notePath
getTitle() {
    # Ask for title
    echo "What title do you want to give today's '$courseFolder' note?"
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

    # Fill course folder name
    complete_course_folder

    # Update note folder with new course name
    noteFolder="$termRoot/$courseFolder/Notes"

    # If course does not use normal note structure and file type
    if [[ "$course" == "example"  ]] ; then
        xdg-open "$termRoot/$courseFolder/notes.docx"
    else
       # Ask user what title they want to give the note
       getTitle
 
       # Create file
       touch "$notePath"

       # Fill in file header and title
       createHeader
       appendTitle

       # Open file
       $EDITOR "$notePath"

       # When file is closed, open its folder in ranger.
       ranger "$noteFolder"
    fi
}

main
