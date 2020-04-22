#!/bin/bash
source ~/.bash_profile
sudo systemctl stop nifi
echo "Stopping Nifi"

cd /opt/nifi

/opt/nifi/bin/nifi.sh stop



