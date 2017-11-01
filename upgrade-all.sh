#! /bin/bash

# Homebrew
    echo "Updating Homebrew lists"
    brew update # Update lists of programs

# Homebrew Casks
    echo "Upgrading Homebrew CLI apps"
    if [[ $(brew outdated) ]] ; then # Check for updates
        brew upgrade # Upgrade CLI programs
        echo "Removing old Homebrew CLI versions"
        brew cleanup # Remove old versions of CLI programs
    else
	echo "All Homebrew CLI apps are up to date."
    fi

# GUI apps & Drivers
    echo "Upgrading Homebrew cask programs (GUI apps and drivers)"
    # Lists outdated casks, remove unneeded info, formats into single line, and saves as string
    outdatedCasks=$(brew cask outdated | awk -F'(' '{print $1}' | paste -s -d' '  -)
    if [[ $outdatedCasks ]] ; then # If there are casks to update
        brew cask reinstall $outdatedCasks # Updates everything in that string
        echo "Removing old cask app versions."
        brew cask cleanup # Cleanup
    else
	echo "All casks are up to date."
    fi

# App Store
    echo "Checking for upgrades in Mac App Store"
    # You haven't killed everything here yet.
    if [[ $(softwareupdate -l | grep -v "Software Update Tool" | grep -v "Checking for upgrades in Mac App Store" | grep -v "No new software available." ) ]] ; then # List upgradable apps
        echo "Upgrading programs from Mac App Store"
        sudo softwareupdate -ia # Upgrade all
    else
	echo "All App Store apps are up to date."
    fi

echo "Updates complete."
