#!/bin/bash

set -euxo pipefail

HADOOP_NN_IP=$1
HADOOP_NN_NAME=$2

cd

# Remove hadoop name node vm from hosts
sudo sed -i "/$HADOOP_NN_IP $HADOOP_NN_NAME/d" /etc/hosts

# Delete hadoop user
#sudo deluser --remove-home hadoop

# Uninstall hadoop
sudo rm -rf /opt/hadoop/
