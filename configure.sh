#!/bin/bash

# ===================================================
# Constants
# ===================================================

RED='\033[0;31m'
GREEN='\033[0;33m'
ORANGE='\033[0;33m'
NC='\033[0m'

# ===================================================
# Functions
# ===================================================

function printHeader() {
    clear
    echo -e "${ORANGE}=======================================${NC}"
    echo -e "${GREEN}$*${NC}"
    echo -e "${ORANGE}=======================================${NC}\n"
}

# ===================================================
# Common Packages
# ===================================================

printHeader "Installing Common Packages"

dnf makecache
dnf install -y vim-enhanced wget curl tree git net-tools epel-release

sleep 2

# ===================================================
# Ansible
# ===================================================

printHeader "Installing Ansible"

dnf install -y ansible

sleep 2

# ===================================================
# Updates
# ===================================================

printHeader "Installing Updates"

dnf -y update
dnf clean all

sleep 2

# ===================================================
# Powerline Fonts
# ===================================================

printHeader "Installing Powerline Fonts"

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# ===================================================
# Vim-Plug
# ===================================================

printHeader "Installing vim-plug Plugin Framework"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sleep 2

# ===================================================
# Download Vim Configuration
# ===================================================

printHeader "Installing Custom Vim Settings"

curl -fLo ~/.vimrc https://raw.githubusercontent.com/wayneboyles/centos-setup/master/.vimrc
vim -E -s -u ~/.vimrc +PlugInstall +qall

sleep 2

# ===================================================
# Finished
# ===================================================

printHeader "Installation Finished"
