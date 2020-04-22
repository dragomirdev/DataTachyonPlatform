#!/bin/bash
source ~/.bash_profile
ps -ef | grep nifi

echo "Starting Nifi"
/opt/nifi/bin/nifi.sh start
sleep 1m
echo "Checking Nifi"
/opt/nifi/bin/nifi.sh status


