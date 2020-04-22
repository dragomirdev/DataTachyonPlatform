#!/bin/bash
source ~/.bash_profile
clear
cd /opt/dtp
echo "Stopping Hive Server 2"
ps aux | grep 'hiveserver2' | awk '{print $2}'  | xargs kill -9
echo "Stopped"


