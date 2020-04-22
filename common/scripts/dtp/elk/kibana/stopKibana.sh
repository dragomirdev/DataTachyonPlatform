#!/bin/bash
source ~/.bash_profile
clear
echo "Stopping Kibana"
cd /opt/dtp
ps aux | grep 'kibana' | awk '{print $2}'  | xargs kill -9

