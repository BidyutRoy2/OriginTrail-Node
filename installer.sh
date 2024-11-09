#!/bin/bash

echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"

# Script to configure firewall and install OriginTrail V8 DKG Core Node

# Step 1: Configure firewall to allow specific ports
echo "Configuring firewall..."
sudo ufw allow 9999 && sudo ufw allow 8900 && sudo ufw allow 9000 && sudo ufw reload
if [ $? -eq 0 ]; then
    echo "Firewall configured successfully with UFW."
else
    echo "Error configuring firewall with UFW."
    exit 1
fi

# Add rules to iptables
sudo iptables -A INPUT -p tcp --dport 9999 -j ACCEPT && \
sudo iptables -A INPUT -p tcp --dport 8900 -j ACCEPT && \
sudo iptables -A INPUT -p tcp --dport 9000 -j ACCEPT
if [ $? -eq 0 ]; then
    echo "Firewall rules added successfully with iptables."
else
    echo "Error adding firewall rules with iptables."
    exit 1
fi

# Step 2: Download OriginTrail V8 DKG Core Node installer
echo "Downloading OriginTrail V8 DKG Core Node installer..."
cd /root/
curl -k -o v8_installer.sh https://raw.githubusercontent.com/OriginTrail/ot-node/v8/develop/installer/v8_installer.sh
if [ $? -eq 0 ]; then
    echo "Installer downloaded successfully."
else
    echo "Error downloading the installer."
    exit 1
fi

# Step 3: Make the installer executable
chmod +x v8_installer.sh
if [ $? -eq 0 ]; then
    echo "Installer script is now executable."
else
    echo "Error making installer script executable."
    exit 1
fi

# Step 4: Execute the installer
echo "Executing the installer..."
./v8_installer.sh
if [ $? -eq 0 ]; then
    echo "OriginTrail V8 DKG Core Node installed successfully."
else
    echo "Error executing the installer."
    exit 1
fi

echo "All steps completed successfully!"
