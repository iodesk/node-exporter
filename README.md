# 🚀 Node Exporter Setup Script

This script automates the process of setting up **Node Exporter** on your Linux server, enabling efficient monitoring and metrics collection with Prometheus. 

The script will:

1. Download and install **Node Exporter**.
2. Set up **basic authentication** with **randomly generated credentials**.
3. Automatically **generate SSL certificates** for secure HTTPS connections.
4. Configure **systemd service** to run Node Exporter as a background service.
5. Provide an easy-to-use **config file** for secure access with authentication.

### ⚡ Features

- **Automated Setup**: Easy, one-click setup of Node Exporter on your server.
- **Secure Authentication**: Randomly generated username & password, with **hashed passwords** stored in the config.
- **SSL Certificates**: Automatically generated **SSL certificates** for secure connections to Node Exporter.
- **Systemd Service**: Fully automated **service creation** for Node Exporter to start on boot.
- **Easy Access**: Your Node Exporter will be ready to use, with credentials and SSL set up!

### 🛠️ Requirements

- A **Linux-based server** (Ubuntu/Debian/Alpine).
- **curl** and **apt-get** installed.
- **openssl** for generating SSL certificates.
- **apache2-utils** for creating htpasswd password hashes.

### 🔥 How to Install

1. **Clone the repository or download the script**

   ```bash
   git clone https://github.com/iodesk/node-exporter.git
   cd node-exporter
2. **Make the script executable**

   ```bash
   chmod +x setup_node_exporter.sh
3. **Run the script with root privileges**
   ```bash
   sudo ./nodex-deb.sh

4. **You can access Node Exporter using your browser or Prometheus directly**
   ```bash
   https://your-server-ip:9100

5. **Uninstall**
   ```bash
   bash uninstall.sh
