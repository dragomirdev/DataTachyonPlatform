#!/bin/bash

sudo chmod -R 775 /opt/nifi-1.9.2/
sudo chown -R hadoop:hadoop /opt/nifi-1.9.2/
ps -ef | grep nifi
echo "Starting Nifi"
/opt/nifi-1.9.2/bin/nifi.sh start
sleep 1m

echo "Checking Nifi"
/opt/nifi-1.9.2/bin/nifi.sh status