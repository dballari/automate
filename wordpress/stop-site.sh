#!/bin/bash

#-----------------------------------------------------------------------
#
# WordPress script - create a new site
#
# The idea comes from the Server Automation repo: https://github.com/evertramos/server-automation 
#
# But this is script is much simpler
#
# Developed by David B
#
#       https://ballarinconsulting.com
#
# Usage
#
# ./start-site.sh folder
#-----------------------------------------------------------------------

echo -e "Folder: $1"

# Stop wp db and wpcli containers
container_sufix="-wp-1"
docker stop "$1${container_sufix}"

container_sufix="-db-1"
docker stop "$1${container_sufix}"

container_sufix="-wpcli-1"
docker stop "$1${container_sufix}"

container_sufix="-pma-1"
docker stop "$1${container_sufix}"
