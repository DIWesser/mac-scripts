#!/bin/bash

# This script should symlink the everything that works

# Scripts are stored in ~/bin
# To access add the following line to .bashrc/bash_profile
# export PATH=~/bin:$PATH

sourceFolder="$HOME/git/scripts"
linkFolder="$HOME/bin"
desktopSource="$sourceFolder/desktop_files"
desktopDest="$HOME/.local/share/applications"
iconSource="$sourceFolder/icons"
iconDest="$HOME/.local/share/icons"

# Create directory
mkdir -p "$HOME/bin"
mkdir -p "$HOME/.local/share/icons"

# Link scripts
ln -s $sourceFolder/calc.sh             $linkFolder/calc
ln -s $sourceFolder/import-notes.sh     $linkFolder/import-notes
ln -s $sourceFolder/is-dropbox-awake.sh $linkFolder/is-dropbox-awake
ln -s $sourceFolder/journal.sh          $linkFolder/journal
ln -s $sourceFolder/linuxcontrol.sh     $linuxcontrol/linuxcontrol
ln -s $sourceFolder/mytime.sh           $linkFolder/mytime
ln -s $sourceFolder/newclassnote.sh     $linkFolder/newclassnote
ln -s $sourceFolder/newmd.sh            $linkFolder/newmd
ln -s $sourceFolder/newvoid.sh          $linkFolder/newvoid
ln -s $sourceFolder/otfplay.sh          $linkFolder/otfplay
ln -s $sourceFolder/pomodoro.sh         $linkFolder/pomodoro
ln -s $sourceFolder/say.sh              $linkFolder/say
ln -s $sourceFolder/straywords.sh       $linkFolder/straywords
ln -s $sourceFolder/themeswitch.sh      $linkFolder/themeswitch
ln -s $sourceFolder/timer.sh            $linkFolder/timer
ln -s $sourceFolder/toggledarktheme     $linkFolder/toggledarktheme
ln -s $sourceFolder/upgrade-all.sh      $linkFolder/upgrade-all
ln -s $sourceFolder/wanip.sh            $linkFolder/wanip

# Link .desktop files
ln -s $desktopSource/daynight.desktop   $desktopDest/daynight.desktop
ln -s $desktopSource/pocket.desktop     $desktopDest/pocket.desktop
ln -s $desktopSource/sep.desktop        $desktopDest/sep.desktop

# Link icons
ln -s $iconSource/daynight.png          $iconDest/daynight.png
ln -s $iconSource/pocket.png            $iconDest/pocket.png
ln -s $iconSource/sep.png               $iconDest/sep.png
