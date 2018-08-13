#!/bin/bash

timeZone="America/Halifax"
author="Daniel Wesser"
title=
newFile=

headerCreationDate=true
headerAuthor=true
headerCourse=false
headerLecturer=false
headerTitle=false
headerDue=false
headerPublisher=false
headerUrl=false
headerMirrorUrl=false
headerTags=false
printHelp=false



echo "---" >> $newFile
if [[ $headerCreationDate == true ]] ; then
    echo "created: $(env TZ=$timeZone date +'%Y-%m-%d')" >> $newFile
fi
if [[ $headerAuthor == true ]] ; then
    echo "author: $author" >> $newFile
fi
echo "---" >> $newFile
