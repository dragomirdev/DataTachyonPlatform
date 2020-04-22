#!/bin/bash
source ~/.bash_profile
clear
echo "Stopping Logstash"
cd /opt/dtp
ps aux | grep 'logstash' | awk '{print $2}'  | xargs kill -9

