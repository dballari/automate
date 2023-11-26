# Automate

This script has been inpired by evertramos' server automation script found here https://github.com/evertramos/server-automation but it's just much simpler and for the moment performs veru little tasks.

To use it first you must use evertramos' easy server script and install nginx proxy.

Then clone this repo and create a .env file using .env.example as a model.

# WordPress new site script

This script allows to create a new instance of wordpress using a repo that may include a site blueprint (with a wp data folder and a db dump).

In the automate/wordpess folder execute the new-site script

```
./new.site.sh folder domain email blueprintrepo
```

Where folder is the name of the folder where the docker setup repo will be clone, domain is the domain of the site, email is the email that will be used to create the letsencrypt certificat and blueprintrepo is the repo that contains the docker setup and the WordPress blueprint. The blueprint repo parameter is optional.

