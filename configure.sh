#!/bin/bash

# ===================================================
# Package Manager
# ===================================================

YUM_CMD=$(which yum)
DNF_CMD=$(which dnf)

# ===================================================
# Version
# Currently only supports CentOS 8.  Additional
# packages are required to fully support CentOS 7
# ===================================================

VERS_FULL=`cat /etc/centos-release | tr -dc '0-9.'`
VERS_MAJOR=$(cat /etc/centos-release | tr -dc '0-9.'|cut -d \. -f1)
VERS_MINOR=$(cat /etc/centos-release | tr -dc '0-9.'|cut -d \. -f2)
VERS_ASYNC=$(cat /etc/centos-release | tr -dc '0-9.'|cut -d \. -f3)

if [ $VERS_MAJOR != "8" ]; then
  clear
  printHeader "Invalid CentOS Release"
  printOutput "Currently this script only supports CentOS 8.  You are running CentOS $VERS_MAJOR"
  exit 1
fi

# ===================================================
# Colors
# ===================================================

RED='\033[0;31m'
GREEN='\033[0;33m'
ORANGE='\033[0;33m'
YELLOW="\033[1;33m"
BLUE="\033[34m"
CYAN="\033[36m"
LIGHT_GREEN="\033[1;32m"
LIGHT_RED="\033[1;31m"
WHITE="\033[1;37m"
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

function printOutput() {
  echo ""
  echo -e "${LIGHT_GREEN}$*${NC}\n"
  sleep 2
}

function installPackage() {
  if [[ ! -z $DNF_CMD ]]; then
    dnf install -y $*
  elif [[ ! -z $YUM_CMD ]]; then
    yum install -y $*
  fi
}

# ===================================================
# Common Packages
# ===================================================

printHeader "Installing Common Packages"

dnf install -y epel-release
dnf install -y vim-enhanced wget curl tree git net-tools figlet

printOutput "Finished Installing Common Packages..."

# ===================================================
# Ansible
# ===================================================

#printHeader "Installing Ansible"

#dnf install -y ansible

#printOutput "Finished Installing Ansible..."

# ===================================================
# Updates
# ===================================================

printHeader "Installing Updates"

dnf -y update
dnf clean all

printOutput "Finished Installing Updates..."

# ===================================================
# Powerline Fonts
# ===================================================

printHeader "Installing Powerline Fonts"

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

printOutput "Finished Installing Powerline Fonts..."

# ===================================================
# Vim-Plug
# ===================================================

printHeader "Installing vim-plug Plugin Framework"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

printOutput "Finished Installing vim-plug Plugin Framework..."

# ===================================================
# Download Vim Configuration
# ===================================================

printHeader "Installing Custom Vim Settings"

curl -fLo ~/.vimrc https://raw.githubusercontent.com/wayneboyles/centos-setup/master/.vimrc
vim -E -s -u ~/.vimrc +PlugInstall +qall

printOutput "Finished Installing Custom Vim Settings..."

# ===================================================
# Download Dynamic MOTD
# ===================================================

printHeader "Installing Dynamic MOTD"

curl -fLo /etc/motd-dynamic.sh https://raw.githubusercontent.com/wayneboyles/centos-setup/master/motd-dynamic.sh
chmod +x /etc/motd-dynamic.sh
echo "/etc/motd-dynamic.sh" >> /etc/profile

printOutput "Finished Installing Dynamic MOTD..."

# ===================================================
# Finished
# ===================================================

printHeader "Finished!"
echo ""
echo -e "${LIGHT_RED}Please log out and back in for all changes to take effect.${NC}"
echo ""
