#!/bin/bash
set -e

GREEN='\e[32m'
YELLOW='\e[33m'
CYAN='\e[36m'
RESET='\e[0m'
BOLD='\e[1m'

cd ~
echo -e "${CYAN}${BOLD}🚀 Downloading Node Exporter...${RESET}"
curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz > /dev/null
sleep 1

echo -e "${YELLOW}${BOLD}🔍 Verifying integrity...${RESET}"
sha256sum node_exporter-1.8.2.linux-amd64.tar.gz

echo -e "${CYAN}${BOLD}📦 Extracting Node Exporter...${RESET}"
tar xvf node_exporter-1.8.2.linux-amd64.tar.gz > /dev/null
sleep 1

echo -e "${CYAN}${BOLD}📦 Installing utils...${RESET}"
apt-get install apache2-utils -y > /dev/null
sleep 1

sudo cp node_exporter-1.8.2.linux-amd64/node_exporter /usr/local/bin
sudo useradd -r -s /bin/false node_exporter
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

rm -rf node_exporter-1.8.2.linux-amd64.tar.gz node_exporter-1.8.2.linux-amd64

echo -e "${CYAN}${BOLD}📦 Setting up service...${RESET}"
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter --web.config.file /etc/node-exporter/config.yml

[Install]
WantedBy=multi-user.target
EOF

sleep 1
echo -e "${YELLOW}${BOLD}📁 Configuring Node Exporter...${RESET}"
sudo mkdir -p /etc/node-exporter/
cd /etc/node-exporter/

RANDOM_USER=admin
RANDOM_PASS=$(openssl rand -base64 12)
HTPASSWD_PASS=$(htpasswd -nbB "$RANDOM_USER" "$RANDOM_PASS" | cut -d ":" -f2)

sudo tee /etc/node-exporter/config.yml > /dev/null <<EOF
tls_server_config:
  cert_file: certificate.crt
  key_file: private.key
basic_auth_users:
  $RANDOM_USER: $HTPASSWD_PASS
EOF

echo -e "${CYAN}${BOLD}🔑 Generating SSL Certificate...${RESET}"
openssl req -newkey rsa:2048 -nodes -keyout private.key -x509 -days 365 -out certificate.crt -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost" > /dev/null

sudo chown -R node_exporter:node_exporter /etc/node-exporter/

sleep 1
echo -e "${GREEN}${BOLD}🚀 Starting Node Exporter...${RESET}"
sudo systemctl daemon-reload 
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

echo -e "${GREEN}${BOLD}🎯 Checking status...${RESET}"
sudo systemctl status node_exporter --no-pager

rm -rf node_exporter-*

echo -e "${GREEN}${BOLD}✅ Installation complete! Access Node Exporter at port 9100.${RESET}"
echo -e "${YELLOW}${BOLD}🌟 Node Exporter is now running like a rocket! 🚀${RESET}"
echo -e "${CYAN}${BOLD}🔑 Generated Credentials:${RESET}"
echo -e "${YELLOW}${BOLD}User: $RANDOM_USER${RESET}"
echo -e "${YELLOW}${BOLD}Password (Text): $RANDOM_PASS${RESET}"
echo -e "${YELLOW}${BOLD}Password (Hash): $HTPASSWD_PASS${RESET}"
exit
