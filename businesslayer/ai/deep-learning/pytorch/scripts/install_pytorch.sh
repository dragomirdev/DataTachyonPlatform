#!/bin/bash

###Note##
#Before running job ...
#(1) Create the users hadoop on AI VM
#(2) Add exception to sudoers file for the users hadoop
#(3) Copy the public key of jenkins user on jenkins VM to hadoop on AI VM

#set -euxo pipefail

# Install dependecies
python3 -V

sudo pip3 install torch spacy==2.0.18 torchvision fastai

sudo apt -y autoremove
pip3 list


