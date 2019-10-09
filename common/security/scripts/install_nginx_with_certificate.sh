#!/bin/bash

cd

echo "DTP Security Installation is started"

# Installing Certbot PPA with nginx apache2-utils
sudo apt-get -y update
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get -y update
sudo apt -y install software-properties-common nginx apache2-utils certbot python-certbot-nginx


#Add a username to the file /etc/nginx/.htpasswd
sudo htpasswd -c /etc/nginx/.htpasswd dtpuser
#Enter Password manually

# Display Entries
cat /etc/nginx/.htpasswd

# Leave out the -c argument for any additional users you wish to add
#sudo htpasswd /etc/nginx/.htpasswd another_user
#Enter Password manually

# Obtaining an Certbot SSL Certificate for the domain names
#sudo certbot --nginx -d example.com -d www.example.com
#On Nifi use the following command using the corresponding dns.name
sudo certbot --nginx -d nifiint.southindia.cloudapp.azure.com

################################################################################################################################################################
# Enter email address (used for urgent renewal and security notices) (Enter 'c' to
# cancel): support@jpyramid.co.uk

# Please read the Terms of Service at
# https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf. You must
# agree in order to register with the ACME server at
# https://acme-v02.api.letsencrypt.org/directory
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# (A)gree/(C)ancel: A

# We'd like to send you email about our work
# encrypting the web, EFF news, campaigns, and ways to support digital freedom.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# (Y)es/(N)o: N

# Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.
-------------------------------------------------------------------------------
# 1: No redirect - Make no further changes to the webserver configuration.
# 2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for
# new sites, or if you're confident your site works on HTTPS. You can undo this
# change by editing your web server's configuration.
-------------------------------------------------------------------------------
# Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 2

# IMPORTANT NOTES:
#  - Congratulations! Your certificate and chain have been saved at:
#    /etc/letsencrypt/live/example.com/fullchain.pem
#    Your key file has been saved at:
#    /etc/letsencrypt/live/example.com/privkey.pem
#    Your cert will expire on 2018-07-23. To obtain a new or tweaked
#    version of this certificate in the future, simply run certbot again
#    with the "certonly" option. To non-interactively renew *all* of
#    your certificates, run "certbot renew"
#  - Your account credentials have been saved in your Certbot
#    configuration directory at /etc/letsencrypt. You should make a
#    secure backup of this folder now. This configuration directory will
#    also contain certificates and private keys obtained by Certbot so
#    making regular backups of this folder is ideal.

################################################################################################################################################################


#Verifying Certbot Auto-Renewal
#To test the renewal process, you can do a dry run with certbot:
sudo certbot renew --dry-run
#To renewal the Cerbot Security in Real Time:
sudo certbot renew

# Configuring Nginx for the given domain or site name
# Sample nginx site file for Nifi
sudo vi /etc/nginx/sites-available/nifiint.southindia.cloudapp.azure.com

server {
    server_name dtp-spark.westindia.cloudapp.azure.com;
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/dtp-spark.westindia.cloudapp.azure.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/dtp-spark.westindia.cloudapp.azure.com/privkey.pem; # managed by Certbot


    location / {
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/.htpasswd;
        proxy_set_header   X-Forwarded-For $remote_addr;
        proxy_set_header   Host $http_host;
        proxy_pass         "http://JP-DTP-SPARK-VM:8080";
    }

}
server {
    if ($host = dtp-spark.westindia.cloudapp.azure.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    listen 80;
    server_name dtp-spark.westindia.cloudapp.azure.com;
    return 404; # managed by Certbot
    
}

# Configuring the default Nginx to be used for the given domain or site name
sudo ln -s /etc/nginx/sites-available/nifiint.southindia.cloudapp.azure.com /etc/nginx/sites-enabled/nifiint.southindia.cloudapp.azure.com
sudo rm /etc/nginx/sites-enabled/default

# Applying & Restart the Nginx Configuration
sudo service nginx restart
sudo service nginx status

# debug nginx via journald
sudo journalctl -xeu nginx

# Enable port 22/80/443 on the Server VM

# Access the Web Application using browser and the username/password
http://nifiint.southindia.cloudapp.azure.com/


