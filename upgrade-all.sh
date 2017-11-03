#! /bin/bash

# Homebrew
    echo -e "\033[1mUpdating Homebrew lists\033[0m"
    brew update # Update lists of programs

# Homebrew Casks
    echo ""
    echo -e "\033[1mUpgrading Homebrew CLI apps\033[0m"
    if [[ $(brew outdated) ]] ; then # Check for updates
        brew upgrade # Upgrade CLI programs
        echo "Removing old Homebrew CLI versions"
        brew cleanup # Remove old versions of CLI programs
    else
	echo "All Homebrew CLI apps are up to date."
    fi

# GUI apps & Drivers
    echo ""
    echo -e "\033[1mUpgrading Homebrew cask programs (GUI apps and drivers)\033[0m"
    # Lists outdated casks, remove unneeded info, formats into single line, and saves as string
    outdatedCasks=$(brew cask outdated | awk -F'(' '{print $1}' | paste -s -d' '  -)
    if [[ $outdatedCasks ]] ; then # If there are casks to update
        brew cask reinstall $outdatedCasks # Updates everything in that string
        echo "Removing old cask app versions."
        brew cask cleanup # Cleanup
    else
	echo "All casks are up to date."
    fi

# macOS
    echo ""
    echo -e "\033[1mUpgrading macOS\033[0m"
    sudo softwareupdate -ia | grep -v 'No updates are available.' \
	    | grep -v 'Software Update Tool' | grep -v 'Finding available software'
    echo "macOS is up to date"

# App Store
    echo ""
    echo -e "\033[1mUpgrading App Store programs\033[0m"
    # Lists outdated apps ecluding those requiring manual authentication
    masOutdated=$(mas list | grep -v '856514119' | grep -v '424389933' | cut -f1 -d' ' |
                  paste -s -d' '  -)
    mas upgrade $masOutdated | grep -v 'Warning: Nothing found to upgrade'
    echo "All App Store apps are up to date."

echo ""
echo -e "\033[1mUpdates complete.\033[0m"
