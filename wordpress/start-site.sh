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

source ../.env
echo -e "Base server path: $BASE_SERVER_PATH"
echo -e "Folder: $1"
cd "${BASE_SERVER_PATH}/$1"
pwd

docker-compose up -d
echo -e "Waiting a bit ... please be patient"

sleep 35

echo -e "Good to go!"
sudo chown -R www-data:www-data wp-app
sudo chown -R root:root wp-data
sudo chmod -R 770 wp-app
echo -e "Changed wp-app and wp-data file owners and/or permissions"
