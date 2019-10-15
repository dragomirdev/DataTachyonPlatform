#!/usr/bin/env bash

## login using
# ssh azureadmin@cicd.southindia.cloudapp.azure.com  -i <local_ssh_keys_folder>/id_rsa

#Jenkins Installation:

sudo apt update
sudo apt -y install openjdk-8-jdk

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt update -y
sudo apt install jenkins -y

sudo systemctl enable jenkins
sudo systemctl status jenkins

#Jenkins Initial password: 
sudo cat /var/lib/jenkins/secrets/initialAdminPassword


