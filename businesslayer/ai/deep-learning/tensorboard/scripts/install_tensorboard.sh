#!/bin/bash

###Note##
#Before running job ...
#(1) Create the users hadoop on AI VM
#(2) Add exception to sudoers file for the users hadoop
#(3) Copy the public key of jenkins user on jenkins VM to hadoop on AI VM

#set -euxo pipefail

# Install dependecies
sudo pip3 install keras textblob nltk -U tensorflow==2.0.0-rc1 --ignore-installed
pip3 list

#################################################### Adding Startup Services #################################################################
sudo mv /home/hadoop/tensorboard.service /etc/systemd/system/
sudo chmod 755 /etc/systemd/system/tensorboard.service
sudo systemctl daemon-reload
sudo systemctl start tensorboard
sudo systemctl enable tensorboard


