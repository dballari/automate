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
# ./new-site.sh folder port pmaport blueprintfolder
#-----------------------------------------------------------------------

source ../../.env
echo -e "Creating new WordPress site in local environment"
echo -e "Base server path: $BASE_SERVER_PATH"
echo -e "Folder: $1"
echo -e "Port: $2"
echo -e "Pma Port: $3"
cd $BASE_SERVER_PATH

# Clone repo with the WordPress - Docker setup in the folder $1
echo -e "Taking the docker setup from default $WORDPRESS_DOCKER_SETUP_REPO"
git clone $WORDPRESS_DOCKER_SETUP_REPO $1


# Create .env file in the folder $1
cd $1
rm -rf .git
cat > .env << EOF

PORT=$2
PMA_PORT=$3
DB_ROOT_PASSWORD=$DEFAULT_DB_ROOT_PASSWORD
DB_NAME=$DEFAULT_DB_NAME
DB_USER=$DEFAULT_DB_USER
DB_PASSWORD=$DEFAULT_DB_PASSWORD
WORDPRESS_TABLE_PREFIX= gX__
LOGGING_OPTIONS_MAX_SIZE=200k

EOF

# Rename docker-compose-loc.yml and env.example.loc files
rm docker-compose.yml
mv docker-compose-loc.yml docker-compose.yml
rm env.example
mv env.example.loc env.example

# Copy wp-app and wp-data folders from blueprintfolder
if [[ $4 == "" ]]; then 
    echo -e "No wp-app and wp-data folders copied"
else
    #echo -e "Updating blueprint db dump $4"
    #cd ..
    #./db-dump.sh $4
    echo -e "Copying wp-app and wp-data folders from $4"
    cp -r ${BASE_SERVER_PATH}/$4/wp-app ${BASE_SERVER_PATH}/$1/wp-app
    cp -r ${BASE_SERVER_PATH}/$4/wp-data ${BASE_SERVER_PATH}/$1/wp-data
    rm -rf ${BASE_SERVER_PATH}/$1/wp-app/.git
    sudo chown -R www-data:www-data wp-app
    sudo chown -R root:root wp-data
    sudo chmod -R 770 wp-app
    echo -e "Changed wp-app and wp-data file owners and/or permissions"
fi

echo -e "To start site please review docker-compose.yml file and execute docker-compose up -d command in the folder that has beeen created or execute the start-site script"
echo -e "An entry may be added in your hosts file for convenience, modifying home and siteurl database options accordingly"
