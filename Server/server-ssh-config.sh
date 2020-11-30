#! /bin/bash

echo "====================================================================="
echo "Attention!: This script is going to copy a preconfigured ssh-config"
echo "file. Please be sure to make changes to this config as needed."
echo "====================================================================="

echo "Copying sshd_config to /etc/ssh/sshd_config. A backup has been created"
sudo cp --archive /etc/ssh/sshd_config /etc/ssh/sshd_config-COPY-$(date +"%Y%m%d%H%M%S")
sudo 
