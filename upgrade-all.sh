#! /bin/bash

# Homebrew
    echo "Updating Homebrew lists"
    brew update # Update lists of programs

# CLI
    echo "Upgrading Homebrew CLI apps"
    brew upgrade # Upgrade CLI programs
    echo "Removing old Homebrew CLI versions"
    brew cleanup # Remove old versions of CLI programs

# GUI apps & Drivers
    echo "Upgrading Homebrew cask programs (GUI apps and drivers)"
    brew cask outdated # List apps that can be updated
    # Todo
        # Pipe the list to something that will `reinstall` all of them
    echo "Removing old verisons of GUI apps and drivers"
    brew cask cleanup # Cleanup

# App Store
    echo "Checking for upgrades in Mac App Store"
    softwareupdate -l # List upgradable apps
    echo "Upgrading programs from Mac App Store"
    sudo softwareupdate -ia # Upgrade all
