#!/bin/bash

# ===========================================================================
# Cleanup
# ===========================================================================
function moves_config() {
    # Step 7
    local msg="cleanup"
    echo "$msg"
    source ~/.zshrc
}

# ===========================================================================
# Moves Config Files
# ===========================================================================
function moves_config() {
    # Step 6
    local msg="moving config files"
    echo "$msg"
    mv .zshrc ~/.zshrc
    mv configfiles/git/.gitconfig ~/.gitconfig
    mv configfiles/git/.gitignore ~/.gitignore
    mv configfiles/hyper/.hyper.js ~/.hyper.js
    mv configfiles/zsh/.zshrc ~/.zshrc
    clean_up
}

# ===========================================================================
# Installs Python3 and Pip
# ===========================================================================
function install_python() {
    # Step 5
    local msg="installing python and pip"
    echo "$msg"
    brew install python3
    pip3 install virtualenv
}

# ===========================================================================
# Installs Popular Applications
# ===========================================================================
function install_zsh() {
    # Step 4
    local msg="installing zsh"
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
    fi
    install_python
}

# ===========================================================================
# Installs Popular Applications
# ===========================================================================
function install_apps() {
    # Step 3
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
    # Step 2
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
    # Step 1
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
    check_cask 
    moves_config && main "$@"
fi