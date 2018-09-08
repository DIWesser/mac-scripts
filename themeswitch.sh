#!/bin/bash

debugOutput=false

setTheme() {
    local theme="$1"
    if [[ $debugOutput ]] ; then
        echo "\`setTheme\` function detects theme as $theme."
        echo "Changing theme."
    fi
    gsettings set org.gnome.desktop.interface gtk-theme "$theme"
    gsettings set org.gnome.desktop.wm.preferences theme "$theme"
}

#setTheme "Minwaita-Vanilla-Dark"
setTheme "Minwaita-Vanilla"
