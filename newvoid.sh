#!/bin/bash

timeZone="America/Halifax"
creationDate="$(env TZ=$timeZone date +'%Y-%m-%d')"
voidDir="$HOME/temporary void"
title=""

getTitle() {
    echo 'What title do you want to give this thought?'
    read "title"
}

main() {
    getTitle
    $EDITOR "$voidDir/$title.md"
    ranger "$voidDir"
}

main
