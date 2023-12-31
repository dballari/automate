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
# ./new-site.sh folder domain pmadomain email blueprintrepo
#-----------------------------------------------------------------------

source ../.env
echo -e "Creating new WordPress site"
echo -e "Base server path: $BASE_SERVER_PATH"
echo -e "Folder: $1"
echo -e "Domain: $2"
cd $BASE_SERVER_PATH

# Clone repo with the WordPress - Docker setup in the folder $1
if [[ $5 == "" ]]; then 
    echo -e "Taking the docker setup from default $WORDPRESS_DOCKER_SETUP_REPO"
    git clone $WORDPRESS_DOCKER_SETUP_REPO $1
else
    echo -e "Taking the docker setup from $4 repo"
    git clone $5 $1
fi

# Create .env file in the folder $1
cd $1
rm -rf .git
cat > .env << EOF

DOMAIN=$2
PMA_DOMAIN=$3
LETSENCRYPT_EMAIL=$4
DB_ROOT_PASSWORD=$DEFAULT_DB_ROOT_PASSWORD
DB_NAME=$DEFAULT_DB_NAME
DB_USER=$DEFAULT_DB_USER
DB_PASSWORD=$DEFAULT_DB_PASSWORD
NETWORK=proxy
WORDPRESS_TABLE_PREFIX= gX__
LOGGING_OPTIONS_MAX_SIZE=200k

EOF

# Delete loc files
rm docker-compose-loc.yml
rm env.example.loc

echo -e "To create site please review docker-compose.yml file and execute docker-compose up -d command in the folder that has beeen created or execute the start-site script"
