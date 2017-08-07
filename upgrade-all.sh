#! /bin/bash

# Homebrew
# Update lists of programs
echo "Updating Homebrew lists"
brew update

# CLI
# Upgrade CLI programs
echo "Upgrading Homebrew CLI apps"
brew upgrade
# Remove old versions of CLI programs
echo "Removing old Homebrew CLI versions"
brew cleanup

# GUI apps & Drivers
# List apps that can be updated
echo "Upgrading Homebrew cask programs (GUI apps and drivers)"
brew cask outdated
# TODO
# Pipe the list to something that will reinstall all of them
echo "Remove old verisons of GUI apps and drivers"
brew cask cleanup

# App Store
# List upgradable apps
echo "Checking for upgrades in Mac App Store"
softwareupdate -l
# Upgrade all
echo "Upgrading programs from Mac App Store"
sudo softwareupdate -ia
