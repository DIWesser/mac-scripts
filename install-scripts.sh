#!/bin/bash

# This script should symlink the everything that works

# Scripts are stored in ~/bin
# To access add the following line to .bashrc/bash_profile
# export PATH=~/bin:$PATH

sourceFolder="$HOME/Git/scripts"
linkFolder="$HOME/bin"

# Create directory
mkdir -p ~/bin
ln -s $sourceFolder/upgrade-all.sh $linkFolder/upgrade-all
ln -s $sourceFolder/pomodoro.sh    $linkFolder/pomodoro
ln -s $sourceFolder/journal.sh     $linkFolder/journal
ln -s $sourceFolder/mytime.sh      $linkFolder/mytime
ln -s $sourceFolder/otfplay.sh     $linkFolder/otfplay
ln -s $sourceFolder/pomodoro.sh    $linkFolder/pomodoro
ln -s $sourceFolder/themeswitch.sh $linkFolder/themeswitch
ln -s $sourceFolder/timer.sh       $linkFolder/timer
ln -s $sourceFolder/wanip.sh       $linkFolder/wanip
ln -s $sourceFolder/calc.sh        $linkFolder/calc
