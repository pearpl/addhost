#
# addhost.sh - Simple hosts file manager for macOS
# Author: Łukasz 'Alien' Kosma
# Homepage: https://pear.pl
# GitHub: https://github.com/pearpl
# Version: 1.0
# License: MIT
#
# Description:
# This script allows you to add, remove, and list hostnames in the /etc/hosts file.
# It is designed to work on macOS and requires sudo privileges to modify the hosts file.
#
# Setup:
# 1. Save this script to a location like $HOME/bin/addhost.sh
#    (you can create the bin directory if it doesn't exist)
#
# 2. Make it executable:
#    chmod +x $HOME/bin/addhost.sh
#
# 3. Add this line to your ~/.bash_profile or ~/.zshrc:
#    alias addhost="$HOME/bin/addhost.sh"
#
# 4. Reload your shell configuration:
#    source ~/.bash_profile     (or source ~/.zshrc)
#
# Then you can use it like a command:
#   addhost add <hostname>    # Add a hostname to 127.0.0.1
#   addhost rm <hostname>     # Remove a hostname
#   addhost list              # List all hostnames
#   addhost help              # Show help
#   addhost ver         # Show version
#

#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

COMMAND="$1"
HOSTNAME="$2"
IP="127.0.0.1"
HOSTS_FILE="/etc/hosts"

list_hosts() {
	grep -vE '^#|^\s*$' "$HOSTS_FILE" | grep "$IP" | awk '{print $2}'
}

case "$COMMAND" in
	add)
		if [ -z "$HOSTNAME" ]; then
			echo "Usage: addhost add hostname"
			exit 1
		fi
		if ! grep -q "$HOSTNAME" "$HOSTS_FILE"; then
			echo "$IP $HOSTNAME" | sudo tee -a "$HOSTS_FILE" > /dev/null
			echo -e "${GREEN}Hostname $HOSTNAME added to $HOSTS_FILE${NC}"
		else
			echo -e "${RED}Hostname $HOSTNAME already exists in $HOSTS_FILE${NC}"
		fi
		;;
	rm)
		if [ -z "$HOSTNAME" ]; then
			echo "Usage: addhost rm hostname"
			exit 1
		fi
		sudo sed -i "" "/$HOSTNAME/d" "$HOSTS_FILE"
		echo -e "${RED}Hostname $HOSTNAME removed from $HOSTS_FILE${NC}"
		;;
	list)
		echo -e "${GREEN}Existing hostnames mapped to $IP:${NC}"
		list_hosts
		;;
	ver)
		echo "addhost.sh version 1.0"
		exit 0
		;;
	help|*)
		echo ""
		echo -e "  ${GREEN}Usage:${NC}"
		echo ""
		echo -e "  ${GREEN}addhost add <hostname>${NC}    Add a hostname to 127.0.0.1"
		echo -e "  ${GREEN}addhost rm <hostname>${NC}     Remove a hostname"
		echo -e "  ${GREEN}addhost list${NC}              List all hostnames"
		echo -e "  ${GREEN}addhost help${NC}              Show this help message"
		echo -e "  ${GREEN}addhost ver${NC}         Show version"
		echo ""

		;;
esac