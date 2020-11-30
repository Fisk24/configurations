#! /bin/bash

# put this in /etc/ufw/applications.d/plexmediaserver
# and then: sudo ufw allow plexmediaserver
"
[PlexMediaServer]
title=Plex Media Server
description=This opens up PlexMediaServer for http (32400), upnp, and autodiscovery.
ports=32469/tcp|32413/udp|1900/udp|32400/tcp|32412/udp|32410/udp|32414/udp|32400/udp
"

