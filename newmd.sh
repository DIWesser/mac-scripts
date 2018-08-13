#!/bin/bash

# Initialize header field toggles
headerAuthor=false          #
headerCourse=false          #
headerCreationDate=false
headerDue=false             #
headerLecturer=false        #
headerPublisher=false       #
headerTags=false            #
headerTitle=false           #
headerUrl=false             #
headerMirrorUrl=false       #


# Metadata variables
date="$(date +'%Y-%m-%d')" #
timeZone=""                #
nonSystemTimezone=false    #
author=""                  #
course=""                  #
lecturer=""                #
dueDate=""                 #
directory=$(pwd)           #
title=""                   #
docType=""                 #
tags=""                    #
url=""                     #
mirrorUrl=""               #
publisher=""               #


# getopts goes here
while getopts ":a:c:d:D:k:l:o:p:t:T:u:U:z:" opt; do
    case $opt in
        a) # Author
            author="$OPTARG" >&2
    		headerAuthor=true
            ;;
        c) # Course
            course="$OPTARG" >&2
            headerCourse=true >&2
            ;;
        d) #Due
            dueDate="$OPTARG" >&2
            headerDue=true >&2
            ;;
        D) # Document type
            docType="$OPTARG" >&2
            ;;
        k) # tags (keywords)
            tags="$OPTARG" >&2
            headerTags=true >&2
            ;;
        l) # Lecturer
            lecturer="$OPTARG" >&2
            headerLecturer=true >&2
            ;;
        o) # output Directory
            directory="$OPTARG" >&2
            ;;
        p) # Publisher
            publisher="$OPTARG" >&2
            headerPublisher=true >&2
            ;;
        t) # Title -- Not in header
            title="$OPTARG" >&2
            ;;
        T) # Title -- include in header
            title="$OPTARG" >&2
            headerTitle=true >&2
            ;;
        u) #Url
            url="$OPTARG" >&2
            headerUrl=true >&2
            ;;
        U) # mirror Url
            mirrorUrl="$OPTARG" >&2
            headerMirrorUrl=true >&2
            ;;
        z) # timeZone
            timeZone="$OPTARG" >&2
            nonSystemTimezone=true >&2
            date="$(env TZ=$timeZone date +'%Y-%m-%d')" >&2
            headerCreationDate=true >&2
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done


# Generate file name
fileName="$date $title.md"
fullPath="$directory/$fileName"

# Make sure file exists
touch "$fullPath"

# Enable header fields based on document type
if [[ $docType == "courseLectureNote" ]] ; then
    headerCreationDate=true
    headerAuthor=true
    headerCourse=true
    headerLecturer=true
elif [[ $docType == "miscNote" ]] ; then
else
    headerCreationDate=true
    headerTitle=true
    headerAuthor=true
fi


echo "---" >> $fullPath
if [[ $headerCreationDate == true ]] ; then
    echo "created: $(env TZ=$timeZone date +'%Y-%m-%d')" >> $fullPath
fi

if [[ $headerCourse == true ]] ; then
    echo "$course" >> $fullPath
fi

if [[ $headerLecturer == true ]] ; then
    echo "$lecturer" >> $fullPath
fi

if [[ $headerAuthor == true ]] ; then
    echo "author: $author" >> $fullPath
fi
echo "---" >> $fullPath
