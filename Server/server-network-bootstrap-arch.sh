#! /bin/bash

# This script is intended to enable basic network connectivity in the event that 
# any better alternative network managment software was not included during base
# system instalation.

if test `id -u` != "0"; then
	echo "This script must be run as root!"
	exit
fi

# Gen or Copy 20-wired.network to /etc/systemd/network
echo "Generating network configuration"
echo "[Match]
Name=en*

[Network]
DHCP=ipv4" > 20-wired.network

mv 20-wired.network

echo "Start/Enable systemd-networkd.service / systemd-resolved.service"
systemctl start systemd-networkd.service systemd-resolved.service
systemctl enable systemd-networkd.service systemd-resolved.service


# reboot, or tell the user that they should
