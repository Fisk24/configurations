#! /bin/bash

echo "Denying all incoming and outgoing traffic."
sudo ufw default deny outgoing comment 'deny all outgoing traffic'
sudo ufw default allow outgoing comment 'allow all outgoing traffic'

echo "Allowing ssh on port 31460 <- use this port and not 22"

echo "Allowing common ports."
# allow traffic out on port 53 -- DNS
sudo ufw allow out 53 comment 'allow DNS calls out'

# allow traffic out on port 123 -- NTP
sudo ufw allow out 123 comment 'allow NTP out'

# allow traffic out for HTTP, HTTPS, or FTP
# apt might needs these depending on which sources you're using
sudo ufw allow out http comment 'allow HTTP traffic out'
sudo ufw allow out https comment 'allow HTTPS traffic out'
sudo ufw allow out ftp comment 'allow FTP traffic out'

# allow whois
sudo ufw allow out whois comment 'allow whois'

# allow traffic out on port 68 -- the DHCP client
# you only need this if you're using DHCP
sudo ufw allow out 68 comment 'allow the DHCP client to update'

sudo ufw enable
sudo systemctl enable ufw.service

echo "Completed... Open more ports manually as needed."
