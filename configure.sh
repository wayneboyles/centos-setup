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
dnf install -y vim-enhanced wget curl tree git net-tools powerline-fonts

sleep 2

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
