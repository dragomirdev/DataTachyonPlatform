#!/bin/bash
source ~/.bash_profile
ps -ef | grep nifi
echo "Checking Nifi"
/opt/nifi/bin/nifi.sh status


