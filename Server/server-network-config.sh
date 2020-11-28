#! /bin/bash

IP=10.0.0.200/24       # The desired static IP address that this machine wishes to obtain at all times
GATEWAY=10.0.0.1    # The Network Gateway IP: This is the IP address of the router closest to this computer on the network (The one its directly connected to)
DNS=10.0.0.1        # DNS Server IP: This is usually the same as the gateway but in some cases it may be neccisary to change it. This script uses this value in addition to google's public DNS (8.8.8.8)

echo "Installing manditory packages. Ensure that you have an active network connection before running this script"
pacman -S openssh networkmanager git vim


# Start and Enable NetworkManager.service
echo "Begin NetworkManager"
#sudo systemctl start NetworkManager
#sudo systemctl enable NetworkManager

echo "Configuring NetworkManager"
connameraw=`nmcli -f NAME con show`
conname=${connameraw:5}
echo $conname

# Start and Enable sshd.service

# Establish static ip address, settable from $IP variable
