#!/bin/bash

set -euxo pipefail

SPARK_WORKER_IP=$1
SPARK_WORKER_NAME=$2

cd

# Remove spark worker vm from hosts
#sudo sed -i "/$SPARK_WORKER_IP $SPARK_WORKER_NAME/d" /etc/hosts

# Delete spark user
#sudo deluser --remove-home spark

pkill -f spark

# Uninstall spark
sudo rm -r /opt/spark/

# ==========

#REMOVE START SPARK AT SYSTEM BOOT!!!!!!!!!!!!!!!!!
#STOP SPARK!!!!!!!!!!!!!!!!!!!!!!!!!!!
