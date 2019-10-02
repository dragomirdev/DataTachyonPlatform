#!/bin/bash

sudo systemctl stop nifi

echo "Stopping Nifi"
/opt/nifi-1.9.2/bin/nifi.sh stop

echo "Checking Nifi"
/opt/nifi-1.9.2/bin/nifi.sh status




