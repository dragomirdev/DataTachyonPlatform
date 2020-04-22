#!/bin/bash
source ~/.bash_profile
clear
echo "Stopping Elasticsearch"
cd /opt/dtp
ps aux | grep 'elasticsearch' | awk '{print $2}'  | xargs kill -9

