#!/bin/bash

defaults write org.eyebeam.SelfControl BlockDuration -int @1
defaults write org.eyebeam.SelfControl HostBlacklist -array facebook.com twitter.com reddit.com instagram.com omgubuntu.co.uk itsfoss.com zdnet.com linuxuprising.com wired.com wired.co.uk
defaults read org.eyebeam.SelfControl
/Applications/SelfControl.app/Contents/MacOS/org.eyebeam.SelfControl $(id -u $(whoami)) --install
