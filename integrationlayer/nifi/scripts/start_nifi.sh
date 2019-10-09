#!/bin/bash

# Default-Start:  2 3 4 5
# Default-Stop: 0 1 6

sudo chmod -R 775 /opt/nifi/
sudo chown -R hadoop:hadoop /opt/nifi/
ps -ef | grep nifi
echo "Starting Nifi"
/opt/nifi/bin/nifi.sh start
sleep 1m

echo "Checking Nifi"
/opt/nifi/bin/nifi.sh status
