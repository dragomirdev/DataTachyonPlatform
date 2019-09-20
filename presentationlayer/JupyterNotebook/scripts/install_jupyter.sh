#!/bin/bash

###Note##
#Before running job ...
#(1) Create the users dtpuser on EdgeNode VM
#(2) Add exception to sudoers file for the users dtpuser
#(3) Copy the public key of jenkins user on jenkins VM to dtpuser on EdgeNode VM

#set -euxo pipefail

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk zip unzip net-tools ncdu inxi dstat iftop vnstat bmon nmap tcpdump nfs-common ack-grep zip unzip htop vim nano
sudo apt -y autoremove

python3 -V

sudo apt -y install  python3-pip python3-dev
sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python3.6 get-pip.py

sudo pip3 install --upgrade notebook
sudo pip3 install ipython-sql cython rpy2

# Login as dtpuser Run the following commands manually.
jupyter notebook --generate-config

# Manual one time step to store password
# jupyter notebook password

# Manual step Run Jupyter Notebook
# jupyter notebook --ip=0.0.0.0 --no-browser




