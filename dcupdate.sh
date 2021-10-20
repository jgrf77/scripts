#!/bin/bash

#A bash script for updating docker containers on my raspberry pi

#homeassistant
cd /docker/config/homeassistant
docker-compose --verbose pull
docker-compose up -d

#monitor
cd /docker/config/monitor
docker-compose --verbose pull
docker-compose up -d

#pihole
cd /docker/config/pihole
docker-compose --verbose pull
docker-compose up -d

#Remove stopped containers, unused networks and dangling (not tagged or referenced by any container) images
#docker system prune
