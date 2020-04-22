#!/bin/bash
source ~/.bash_profile
clear
cd /opt/dtp
echo "Stopping LIVY"
ps aux | grep 'livy' | awk '{print $2}'  | xargs kill -9


