#!/bin/bash

###Note##
#Before running job ...
#(1) Create the users hadoop on AI VM
#(2) Add exception to sudoers file for the users hadoop
#(3) Copy the public key of jenkins user on jenkins VM to hadoop on AI VM

#set -euxo pipefail

# Install dependecies
sudo apt -y install  python3-pip python3-dev
sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python3.6 get-pip.py
sudo pip3 install -U setuptools pip
sudo pip3 install keras textblob nltk -U tensorflow==2.0.0-rc1 --ignore-installed

pip3 list

echo "deb [arch=amd64] http://storage.googleapis.com/tensorflow-serving-apt stable tensorflow-model-server tensorflow-model-server-universal" | sudo tee /etc/apt/sources.list.d/tensorflow-serving.list && \
curl https://storage.googleapis.com/tensorflow-serving-apt/tensorflow-serving.release.pub.gpg | sudo apt-key add -

sudo apt-get -y update & sudo apt-get -y install tensorflow-model-server
sudo apt-get -y upgrade tensorflow-model-server

sudo pip3 install requests

pip3 list
