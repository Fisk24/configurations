#! /bin/bash

if test `id -u` != "0" ; then
	echo "This script must be run as root."
	exit
fi

if test "$1" == "uninstall"; then
	echo "===================================================================================="
	echo "## WARNING: This script will only remove the Systemd unit and the minecraft user. ##"
	echo "## Existing server instances will NOT be deleted!                                 ##"
	echo "## By default server instances are stored in /opt/minecraft                       ##"
	echo "===================================================================================="

	echo "===================================================================================="
	echo "## Stopping All Minecraft Server Instances...                                     ##"
	echo "===================================================================================="
	
	out=`sudo runuser -l minecraft -c "tmux list-sessions"` 
	for LINE in $(echo "$out" | grep -o -E '.*?mc-[^:]*')
	do
		suffix=${LINE:3}
		echo "Stopping $suffix"
		systemctl stop minecraft@$suffix
	done

	echo "===================================================================================="
	echo "## Removing System Configuration...                                               ##"
	echo "===================================================================================="
	
	userdel minecraft
	rm /etc/systemd/system/minecraft@.service

	echo "===================================================================================="
	echo "## Removing Files...                                                              ##"
	echo "===================================================================================="
	
	# Remove my conveinence scripts from the path at this point as well?
	echo "Done."

elif test "$1" == "install"; then
	echo "===================================================================================="
	echo "## Installing Prerequisites...                                                    ##"
	echo "===================================================================================="

	sudo pacman -S jre8-openjdk-headless wget tmux nano grep
	echo "===================================================================================="
	echo "## Configuring System...                                                          ##"
	echo "===================================================================================="

	mkdir /opt
	mkdir /opt/minecraft
	groupadd minecraft	
	useradd --system --shell /bin/bash --home-dir /opt/minecraft --gid minecraft minecraft
	chown -R minecraft:minecraft /opt/minecraft 	

	echo "===================================================================================="
	echo "## Copying Files...                                                               ##"
	echo "===================================================================================="
	cp ./minecraft@.service /etc/systemd/system/minecraft@.service
	# Deploy my conveinence scripts to the path at this point as well?
	echo "Done."

else
	echo "$0 [install|uninstall]"

fi



