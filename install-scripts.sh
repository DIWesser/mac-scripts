#! /bin/bash

# This script should symlink the everything that works

# Scripts are stored in ~/bin
# To access add the following line to .bashrc/bash_profile
# export PATH=~/bin:$PATH

# Create directory
mkdir -p ~/bin
ln -s ~/Git/mac-scripts/upgrade-all.sh ~/bin/upgrade-all
