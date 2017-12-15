#! /bin/bash
# This script takes all of the different package managers I use or have used and
# puts them into a single script.

#################################################################################
# Homebrew
#################################################################################
if [[ $(command -v brew) ]] ; then
    echo -e "\033[1mUpdating Homebrew lists\033[0m"
    brew update # Update lists of programs

    #############################################################################
    # Homebrew CLI Apps
    #############################################################################
    echo ""
    echo -e "\033[1mUpgrading Homebrew CLI apps\033[0m"
    if [[ $(brew outdated) ]] ; then # Check for updates
        brew upgrade # Upgrade CLI programs
        echo "Removing old Homebrew CLI versions"
        brew cleanup # Remove old versions of CLI programs
    else
	echo "All Homebrew CLI apps are up to date."
    fi

    #############################################################################
    # GUI apps & Drivers
    #############################################################################
    echo ""
    echo -e "\033[1mUpgrading Homebrew cask programs (GUI apps and drivers)\033[0m"
    # Lists outdated, trim unneeded info, format to one line, save as string
    outdatedCasks=$(brew cask outdated | awk -F'(' '{print $1}' |
        paste -s -d' '  -)
    if [[ $outdatedCasks ]] ; then # If there are casks to update
        brew cask reinstall $outdatedCasks # Updates everything in string
        echo "Removing old cask app versions."
        brew cask cleanup # Cleanup
    else
	echo "All casks are up to date."
    fi
fi
#################################################################################
# Python pip packages
#################################################################################
if [[ $(command -v pip2 && command -v pip3) ]] ; then
    echo -e "\033[1mUpgrading pip (Python) programs.\033[0m"

    #############################################################################
    # pip2
    #############################################################################
    if [[ $(command -v pip2) ]] ; then
        echo -e "\033[1mpip2\033[0m"
        # Lists outdated, trim unneeded info, format to one line, save as string
        pip2Outdated=$(pip2 list --outdated --format=legacy |
            awk -F'(' '{print $1}' | paste -s -d' '  -)
        if [[ $pip2Outdated ]] ; then # If there are pips to update
            pip2 install --upgrade $pip2Outdated # Updates everything in string
            echo "Removing old cask app versions."
            brew cask cleanup # Cleanup
        else
		echo "All casks are up to date."
        fi
    fi

    #############################################################################
    # pip3
    #############################################################################
    if [[ $(command -v pip3) ]] ; then
        echo -e "\033[1mpip3\033[0m"
        # Lists outdated, trim unneeded info, format to one line, save as string
        pip3Outdated=$(pip3 list --outdated --format=legacy |
            awk -F'(' '{print $1}' | paste -s -d' '  -)
        if [[ $pip3Outdated ]] ; then # If there are pips to update
            pip3 install --upgrade $pip3Outdated # Updates everything in string
            echo "Removing old cask app versions."
            brew cask cleanup # Cleanup
        else
		echo "All casks are up to date."
        fi
    fi
fi
#################################################################################
# macOS
#################################################################################
if [[ $(command -v softwareupdate) ]] ; then
    echo ""
    echo -e "\033[1mUpgrading macOS\033[0m"
    sudo softwareupdate -ia | grep -v 'No updates are available.' \
	    | grep -v 'Software Update Tool' | grep -v 'Finding available software'
    echo "macOS is up to date"
fi
#################################################################################
# App Store
#################################################################################
if [[ $(command -v mas) ]] ; then
    echo ""
    echo -e "\033[1mUpgrading App Store programs\033[0m"
    # Lists outdated apps ecluding those requiring manual authentication
    masOutdated=$(mas list | grep -v '856514119' | grep -v '424389933' |
        cut -f1 -d' ' | paste -s -d' '  -)
    mas upgrade $masOutdated | grep -v 'Warning: Nothing found to upgrade'
    echo "All App Store apps are up to date."
fi
#################################################################################
# End Message
#################################################################################
    echo ""
    echo -e "\033[1mUpdates complete.\033[0m"
