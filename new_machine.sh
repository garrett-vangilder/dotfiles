#!/bin/bash

# ===========================================================================
# Moves Config Files
# ===========================================================================
function moves_config() {
    local msg="moving config files"
    echo "$msg"
    mv .zshrc ~/.zshrc
}

# ===========================================================================
# Installs Python3 and Pip
# ===========================================================================
function install_python() {
    local msg="installing python and pip"
    echo "$msg"
    brew install python3
    pip3 install virtualenv
}

# ===========================================================================
# Installs Popular Applications
# ===========================================================================
function install_zsh() {
    local msg="installing python and pip"
    echo "$msg"
    if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
        if [[ ! -d $dir/oh-my-zsh/ ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        fi
        if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
        fi
    else
        echo "We'll install zsh, then re-run this script!"
        brew install zsh
        source ~/.zshrc
    fi
}

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
    brew cask install slack
    install_zsh
}


# ===========================================================================
# Brew Cask Installer
# ===========================================================================
function install_cask() {

    # Get the Latest Version
    if brew ls --versions myformula > /dev/null; then
        ruby <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
    else
        brew update
    fi
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
    echo "Welcome to your new machine. This will build your dev environment."
    check_cask && main "$@"
fi