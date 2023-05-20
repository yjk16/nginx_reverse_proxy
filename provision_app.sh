#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Provisioning for app VM
# Update and Upgrade the VM
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Nginx
sudo apt-get install nginx -y

sudo systemctl start nginx -y

# # Install Git
# sudo apt-get install git -y

# Install Python Properties
sudo apt-get install python-software-properties -y

# Install NodeJS
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install pm2 globally
sudo npm install pm2 -g

# The following do manually after cd-ing into relevant app folder:
# npm install
# node app.js

# change the necessary details for the reverse proxy
new_file="
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name 192.168.10.100;

        location / {
                proxy_pass http://localhost:3000;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
        }

        location /posts {
                proxy_pass http://localhost:3000/posts;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
    }
}
"
new_file > /etc/nginx/sites-available/default