#!/bin/bash

###Note##
#Before running job ...
#(1) Create the users hadoop on AI VM
#(2) Add exception to sudoers file for the users hadoop
#(3) Copy the public key of jenkins user on jenkins VM to hadoop on AI VM

#set -euxo pipefail

# Install dependecies
sudo pip3 install -U numpy scipy pandas scikit-learn==0.19.2 hdfs gensim xgboost

pip3 list


