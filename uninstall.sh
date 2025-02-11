#!/bin/bash
set -e

GREEN='\e[32m'
YELLOW='\e[33m'
RED='\e[31m'
CYAN='\e[36m'
RESET='\e[0m'
BOLD='\e[1m'

echo -e "${RED}${BOLD}🚨 Uninstalling Node Exporter...${RESET}"
sleep 1

# Stopping service
echo -e "${YELLOW}${BOLD}🛑 Stopping Node Exporter service...${RESET}"
sudo systemctl stop node_exporter || echo -e "${RED}⚠️ Failed to stop service!${RESET}"
sudo systemctl disable node_exporter || echo -e "${RED}⚠️ Failed to disable service!${RESET}"
sleep 1

# Removing files
echo -e "${CYAN}${BOLD}🗑️ Removing Node Exporter files...${RESET}"
sudo rm -rf /usr/local/bin/node_exporter
sudo rm -rf /etc/systemd/system/node_exporter.service
sudo rm -rf /etc/node-exporter/
sleep 1

# Deleting user
echo -e "${CYAN}${BOLD}👤 Removing Node Exporter user...${RESET}"
sudo userdel node_exporter || echo -e "${RED}⚠️ Failed to remove user!${RESET}"
sleep 1

# Reloading systemd
echo -e "${YELLOW}${BOLD}🔄 Reloading system daemon...${RESET}"
sudo systemctl daemon-reload
sleep 1

# Final check
echo -e "${GREEN}${BOLD}✅ Uninstallation complete! Node Exporter has been removed.${RESET}"
exit
