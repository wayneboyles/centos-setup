#!/bin/bash

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

# Hostname

printf "\n"$LIGHT_GREEN
figlet "  "$(hostname -s)
printf $NC

# Gather System Information

date=`date`
load=`cat /proc/loadavg | awk '{print $1}'`
root_usage=`df -h / | awk '/\// {print $(NF-1)}'`
memory_usage=`free -m | awk '/Mem:/ { total=$2 } /buffers\/cache/ { used=$3 } END { printf("%3.1f%%", used/total*100)}'`
swap_usage=`free -m | awk '/Swap/ { printf("%3.1f%%", "exit !$2;$3/$2*100") }'`
users=`users | wc -w`
time=`uptime | grep -ohe 'up .*' | sed 's/,/\ hours/g' | awk '{ printf $2" "$3 }'`
processes=`ps aux | wc -l`
ethup=$(ip -4 ad | grep 'state UP' | awk -F ":" '!/^[0-9]*: ?lo/ {print $2}')
ip=$(ip ad show dev $ethup |grep -v inet6 | grep inet|awk '{print $2}')
release=`cat /etc/redhat-release`

# Print current date and time
printf "${WHITE}  System information as of: ${LIGHT_RED}$date${NC}\n\n"

# System load and IP address
printf "${WHITE}  System load:${LIGHT_GREEN}\t%s\t${WHITE}IP Address:${LIGHT_GREEN}\t%s\n${NC}" $load $ip

# Memory usage and system uptime
printf "${WHITE}  Memory usage:${LIGHT_GREEN}\t%s\t${WHITE}System uptime:${LIGHT_GREEN}\t%s\n${NC}" $memory_usage "$time"

# Disk usage and swap usage
printf "${WHITE}  Usage on /:${LIGHT_GREEN}\t%s\t${WHITE}Swap usage:${LIGHT_GREEN}\t%s\n${NC}" $root_usage $swap_usage

# Number of users and number of Processes
printf "${WHITE}  Local Users:${LIGHT_GREEN}\t%s\t${WHITE}Processes:${LIGHT_GREEN}\t%s\n${NC}" $users $processes

# Blank line
echo ""
