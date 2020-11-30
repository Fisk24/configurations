#! /bin/bash

# Ensure that this command is run as root
if test `id -u` != "0"; then
	echo "This script must be run as root!"
	exit
fi

IP=10.0.0.200/24       # The desired static IP address that this machine wishes to obtain at all times
GATEWAY=10.0.0.1    # The Network Gateway IP: This is the IP address of the router closest to this computer on the network (The one its directly connected to)
DNS=10.0.0.1        # DNS Server IP: This is usually the same as the gateway but in some cases it may be neccisary to change it. This script uses this value in addition to google's public DNS (8.8.8.8)

echo "Installing manditory packages. Ensure that you have an active network connection before running this script"
pacman -S openssh networkmanager git vim python

# Stop/Disable systemd-networkd and systemd-resolved

sudo systemctl stop systemd-networkd systemd-resolved
sudo systemctl disable systemd-networkd systemd-resolved

# Start and Enable NetworkManager.service
echo "Begin NetworkManager"
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager

echo "Configuring NetworkManager"
./nmconfig.py $IP $GATEWAY $DNS
echo "Static IP established..."
echo "Completed Configuring NetworkManager"

# Start and Enable sshd.service
echo "Begin sshd"
sudo systemctl start sshd
sudo systemctl enable sshd

echo "SSH is up on port 22. Change this immediatly"

echo "Basic network configuration complete!"
echo "Please reboot the server, for the changes to take effect."


