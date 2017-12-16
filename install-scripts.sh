#! /bin/bash

# This script should symlink the everything that works

# Scripts are stored in ~/bin
# To access add the following line to .bashrc/bash_profile
# export PATH=~/bin:$PATH

sourceFolder="$HOME/Git/scripts"
linkFolder="$HOME/bin"

# Create directory
mkdir -p ~/bin
ln -s $sourceFolder/upgrade-all.sh $linkFolder/upgrade-all
