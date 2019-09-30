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

# Run commands as hadoop user and expand variables
sudo -i -u hadoop bash << 'EOF'

echo "hadoop user"
cd

EOF


# Run commands as hadoop user and expand variables
sudo -i -u hadoop bash << EOF

sudo systemctl stop spark
sudo rm -rf /etc/systemd/system/spark.service
sudo systemctl daemon-reload

EOF


