#! /bin/bash
# This script takes all of the different package managers I use or have used and
# puts them into a single script.

# Homebrew
homebrewUpdate () {
    if [[ $(command -v brew) ]] ; then
        echo -e "\033[1mUpdating Homebrew lists\033[0m"
        brew update # Update lists of programs
    fi
}

# Homebrew CLI Apps
homebrewCliUpgrade () {
    if [[ $(command -v brew) ]] ; then
        echo ""
        echo -e "\033[1mUpgrading Homebrew CLI apps\033[0m"
        if [[ $(brew outdated) ]] ; then # Check for updates
            brew upgrade # Upgrade CLI programs
            echo "Removing old Homebrew CLI versions"
            brew cleanup # Remove old versions of CLI programs
        else
        echo "All Homebrew CLI apps are up to date."
        fi
    fi
}


# GUI apps & Drivers
homebrewCaskUpgrade () {
    if [[ $(command -v brew) ]] ; then
        echo ""
        echo -e "\033[1mUpgrading Homebrew cask programs (GUI apps and drivers)\033[0m"
        if [[ $(brew cask outdated) ]] ; then # If there are casks to update
            brew cask upgrade # Upgrade cask apps
            echo "Removing old cask app versions."
            brew cleanup # Cleanup
        else
        echo "All casks are up to date."
        fi
    fi
}


# pip2
pip2Upgrade () {
    if [[ $(command -v pip2) ]] ; then
        echo -e "\033[1mUpgrading Python pip2 programs.\033[0m"
        # Lists outdated, trim unneeded info, format to one line, save as string
        pip2Outdated=$(pip2 list --outdated --format=legacy |
            awk -F'(' '{print $1}' | paste -s -d' '  -)
        if [[ $pip2Outdated ]] ; then # If there are pips to update
            echo "Upgrading pip2 apps."
            pip2 install --upgrade "$pip2Outdated" # Updates everything in string
        else
	        echo "All pip2 apps are up to date."
        fi
    fi
}

# pip3
pip3Upgrade () {
    if [[ $(command -v pip3) ]] ; then
        echo -e "\033[1mUpgrading Python pip3 programs.\033[0m"
        # Lists outdated, trim unneeded info, format to one line, save as string
        pip3Outdated=$(pip3 list --outdated --format=legacy |
            awk -F'(' '{print $1}' | paste -s -d' '  -)
        if [[ $pip3Outdated ]] ; then # If there are pips to update
            echo "Upgrading pip3 apps."
            pip3 install --upgrade "$pip3Outdated" # Updates everything in string
        else
	        echo "All pip3 are up to date."
        fi
    fi
}


# macOS
macosUpgrade () {
if [[ $(command -v softwareupdate) ]] ; then
    echo ""
    echo -e "\033[1mUpgrading macOS\033[0m"
    sudo softwareupdate -ia | grep -v 'No updates are available.' \
	    | grep -v 'Software Update Tool' | grep -v 'Finding available software'
    echo "macOS is up to date"
fi
}


# App Store
masUpgrade () {
    if [[ $(command -v mas) ]] ; then
        echo ""
        echo -e "\033[1mUpgrading App Store programs\033[0m"
        # Lists outdated apps ecluding those requiring manual authentication
        masOutdated=$(mas list | grep -v '856514119' | grep -v '424389933' |
            cut -f1 -d' ' | paste -s -d' '  -)
        mas upgrade "$masOutdated" | grep -v 'Warning: Nothing found to upgrade'
        echo "All App Store apps are up to date."
    fi
}


# LaTeX Packages
latexPackageUpgrade () {
    if [[ $(command -v tlmgr) ]] ; then
        echo ""
        echo -e "\033[1mUpgrading LaTeX Packages\033[0m"
        sudo tlmgr update --self --all
    fi
}


# Microsoft Office
microsoftOfficeUpgrade () {
    if [[ $(command -v /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate) ]] ; then
        echo ""
        echo -e "\033[1mUpgrading Microsoft Office Programs\033[0m"
        /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate --install
    fi
}

# apt (Ubuntu, Debian, and derivatives)
aptUpgrade () {
    if [[ $(command -v apt) ]] ; then
        sudo apt update # Update package lists
        sudo apt upgrade -y # Install all packages
    fi
}


main () {
    homebrewUpdate
    homebrewCliUpgrade
    homebrewCaskUpgrade
    pip2Upgrade
    pip3Upgrade
    macosUpgrade
    masUpgrade
    latexPackageUpgrade
    microsoftOfficeUpgrade

    echo ""
    echo -e "\033[1mUpdates complete.\033[0m"
    echo -e "\033[1mSome apps may require a reboot to be used.\033[0m"
}

main
