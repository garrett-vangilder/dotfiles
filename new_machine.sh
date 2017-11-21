#!/bin/bash

# ===========================================================================
# Installs Popular Applications
# ===========================================================================
function install_apps() {
    local msg="installing popular apps"
    echo "$msg"
    brew install git
    brew install node
    brew cask install hyper
    brew cask install google-chrome
    brew cask install visual-studio-code
    brew cask install postman
}


# ===========================================================================
# Brew Cask Installer
# ===========================================================================
function install_cask() {

    # Get the Latest Version
    ruby <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
    brew update
    brew upgrade

    # Install
    brew install caskroom/cask/brew-cask
}


function check_cask() {
    # Ensure Cask is Installed
    local msg="brew cask not installed, installing"

    if ! type -P "brew-cask" > /dev/null; then
        echo "$msg" && install_cask
    fi
    install_apps
}

# ===============================================================================
# Entry Point
# ===============================================================================
if [ "$0" = "${BASH_SOURCE}" ]; then
    check_cask && main "$@"
fi