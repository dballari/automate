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
# ./new-site.sh folder domain email blueprintrepo
#-----------------------------------------------------------------------

source ../.env
echo -e "Creating new WordPress site"
echo -e "Base server path: $BASE_SERVER_PATH"
echo -e "Folder: $1"
echo -e "Domain: $2"
cd $BASE_SERVER_PATH

# Clone repo with the WordPress - Docker setup in the folder $1
if [[ $4 == "" ]]; then 
    echo -e "Taking the docker setup from default $WORDPRESS_DOCKER_SETUP_REP"
    git clone $WORDPRESS_DOCKER_SETUP_REPO $1
else
    echo -e "Taking the docker setup from $4 repo"
    git clone $4 $1
fi

# Create .env file in the folder $1
cd $1
cat > .env << EOF

DOMAIN=$2
LETSENCRYPT_EMAIL=$3
DB_ROOT_PASSWORD=$DEFAULT_DB_ROOT_PASSWORD
DB_NAME=$DEFAULT_DB_NAME
DB_USER=$DEFAULT_DB_USER
DB_PASSWORD=$DEFAULT_DB_PASSWORD
NETWORK=proxy
WORDPRESS_TABLE_PREFIX= gX__
LOGGING_OPTIONS_MAX_SIZE=200k

EOF

# Create docker container with docker compose
docker-compose up -d

# List containers
docker ps

echo -e "Script finished please look at the docker containers' logs in case the site is not correctly created"
