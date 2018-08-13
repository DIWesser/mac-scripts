#!/bin/bash

# Initialize header field toggles
headerAuthor=false
headerCourse=false
headerCreationDate=false
headerDue=false
headerLecturer=false
headerMirrorUrl=false
headerPublisher=false
headerTags=false
headerTitle=false
headerUrl=false


# getopts goes here


# Metadata variables
timeZone="America/Halifax"
nonSystemTimezone=true
if [[ $nonSystemTimezone == true ]] ; then
    date="$(env TZ=$timeZone date +'%Y-%m-%d')"
else
    date="$(date +'%Y-%m-%d')"
fi
author="Daniel Wesser"
course=""
lecturer=""
directory=$(pwd)
fileName="$date $title.md"
filePath="$fileName/$directory"
title=""
docType=""


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


echo "---" >> $filePath
if [[ $headerCreationDate == true ]] ; then
    echo "created: $(env TZ=$timeZone date +'%Y-%m-%d')" >> $filePath
fi

if [[ $headerCourse == true ]] ; then
    echo "$course" >> $filePath
fi

if [[ $headerLecturer == true ]] ; then
    echo "$lecturer" >> $filePath
fi

if [[ $headerAuthor == true ]] ; then
    echo "author: $author" >> $filePath
fi
echo "---" >> $filePath
