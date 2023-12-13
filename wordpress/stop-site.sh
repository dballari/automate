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
# ./start-site.sh folder destroydata(true/false)
#-----------------------------------------------------------------------

source ../.env
echo -e "Base server path: $BASE_SERVER_PATH"
echo -e "Folder: $1"
cd "${BASE_SERVER_PATH}/$1"
pwd

if [[ $2 ]]; then 
    echo -e "Stopping and removing data volume"
    docker-compose down -v
else
    echo -e "Stopping"
    docker-compose down
fi
