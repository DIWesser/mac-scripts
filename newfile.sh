#! /bin/bash

timeZone = "America/Halifax"
author = "Daniel Wesser"
newFile = 

includeCreationDate = true
includeAuthor = true
includeCourse = false
includeInstructor = false

echo "---" >> $newFile
if [[ $includeCreationDate == true ]] ; then
    echo "created: $(env TZ=$timeZone date +'%Y-%m-%d')" >> $newFile
fi
if [[ $includeAuthor == true ]] ; then
    echo "author: $author" >> $newFile
fi
echo "---" >> $newFile
