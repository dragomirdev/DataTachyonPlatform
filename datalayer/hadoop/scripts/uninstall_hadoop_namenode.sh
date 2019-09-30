#!/bin/bash

set -euxo pipefail

HADOOP_SNN_IP=$1
HADOOP_SNN_NAME=$2

HADOOP_DN_ONE_IP=$3
HADOOP_DN_ONE_NAME=$4

HADOOP_DN_TWO_IP=$5
HADOOP_DN_TWO_NAME=$6

cd

# Remove 2nd name node and data node vm's from hosts
sudo sed -i "/$HADOOP_SNN_IP $HADOOP_SNN_NAME/d" /etc/hosts
sudo sed -i "/$HADOOP_DN_ONE_IP $HADOOP_DN_ONE_NAME/d" /etc/hosts
sudo sed -i "/$HADOOP_DN_TWO_IP $HADOOP_DN_TWO_NAME/d" /etc/hosts

# Delete hadoop user
#sudo deluser --remove-home hadoop

# Stop Hadoop
stop-dfs.sh

# Uninstall hadoop
sudo rm -rf /opt/hadoop/

# ==========

#REMOVE START HADOOP AT SYSTEM BOOT!!!!!!!!!!!!!!!!!
#STOP HADOOP!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Run commands as hadoop user and expand variables
sudo -i -u hadoop bash << 'EOF'

echo 'Hadoop user'
cd

EOF

# Run commands as hadoop user and expand variables
sudo -i -u hadoop bash << EOF

sudo systemctl stop hadoop
sudo rm -rf /etc/systemd/system/hadoop.service
sudo systemctl daemon-reload

EOF

