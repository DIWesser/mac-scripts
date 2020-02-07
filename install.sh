#!/bin/bash

# Scripts are stored in ~/bin
# To access add the following line to .bashrc/bash_profile
# export PATH=~/bin:$PATH


sourceFolder="$(pwd)"
linkFolder="$HOME/bin"
desktopSource="$sourceFolder/desktop_files"
desktopDest="$HOME/.local/share/applications"
iconSource="$sourceFolder/icons"
iconDest="$HOME/.local/share/icons"


# Takes full path then root path
between_root_and_ext () {
    fullPath="$1"
    rootPath="$2"
    noRootWithExt="${fullPath#$rootPath}"
    noRootOrExt="${noRootWithExt%.*}"
    echo "$noRootOrExt"
}


install_scripts () {
    mkdir -p "$linkFolder"

    for script in ./*.sh
    do
        script=${script:2}
        scriptTitle="$(between_root_and_ext '$script' '$sourceFolder')"
        if [ "$script" != *install.sh ] ; then
            echo -n "Do you want to link $script? [y/N]: "
            read install
            if [[ "$install" = Y ]] || [[ "$install" == y ]] ; then
                ln -s  "$sourceFolder/$script" "$linkFolder/$scriptTitle"
            fi
        fi
    done
}


install_dot_desktop () {
    mkdir -p "$desktopDest"
    mkdir -p "$iconDest"

    for desktop in "$desktopSource/"*.desktop
    do
        desktopTitle="$(between_root_and_ext '$desktop' '$desktopSource')"
        desktopTitle="${desktopTitle:1}"
        echo -n "Would you like to link $desktopTitle.desktop? [y/N]: "
        read install
        if [[ "$install" == Y ]] || [[ "$install" == y ]] ; then
            ln -s "$desktopSource/$desktopTitle.desktop" \
                "$desktopDest/$desktopTitle.desktop"
            ln -s "$iconSource/$desktopTitle.png" "$iconDest/$desktopTitle.png"
        fi
    done
}


# main
install_scripts
install_dot_desktop
echo "Install complete. Note that \$PATH must include \$HOME/bin for scripts to be accessed."
