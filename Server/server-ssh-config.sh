#! /bin/bash

if test `id -u` != "0"; then
	echo "This script must be run as root!"
	exit
fi

echo "====================================================================="
echo "Attention!: This script is going to copy a preconfigured ssh-config"
echo "file. Please be sure to make changes to this config as needed."
echo "====================================================================="

if test -f "sshd_config"; then
	echo "ERROR: sshd_config file not found"
	echo "This script requires that sshd_config with the desired "
	echo "modifications made, to be placed in the same directory "
	echo "as this script."
	exit
fi

echo "Copying sshd_config to /etc/ssh/sshd_config. A backup has been created"
sudo cp --archive /etc/ssh/sshd_config /etc/ssh/sshd_config-COPY-$(date +"%Y%m%d%H%M%S")
sudo cp sshd_config /etc/ssh/sshd_config

echo "Removing Short Diffie-Hellman Keys"
sudo cp --archive /etc/ssh/moduli /etc/ssh/moduli-COPY-$(date +"%Y%m%d%H%M%S")
sudo awk '$5 >= 3071' /etc/ssh/moduli | sudo tee /etc/ssh/moduli.tmp
sudo mv /etc/ssh/moduli.tmp /etc/ssh/moduli

echo "Setting up 2FA/MFA with google authenticator"
sudo pacman -S libpam-google-authenticator qrencode
echo "|| > WARNING: google-authenticator MUST NOT BE RUN AS ROOT!!!!!"
echo "|| > please execute: google-authenticator after this script is finished..."

echo "Adjusting PAM rules to reflect authenticator policies"
sudo cp --archive /etc/pam.d/sshd /etc/pam.d/sshd-COPY-$(date +"%Y%m%d%H%M%S")
echo -e "\nauth       required     pam_google_authenticator.so nullok         # added by $(whoami) on $(date +"%Y-%m-%d @ %H:%M:%S")" | sudo tee -a /etc/pam.d/sshd

echo "Setting local time to use ntp time syncronization so that authenticator codes work"
timedatectl set-ntp true

echo "Restarting sshd.service"
systemctl restart sshd.service

echo "Completed ssh configuration!"
echo "You must now run \"google-authenticator\" as your personal user"
echo "DO NOT under any circumstances run is as root"
