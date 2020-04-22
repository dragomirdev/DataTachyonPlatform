#!/bin/bash
source ~/.bash_profile
clear
echo "Stopping HUE"
cd /opt/dtp
ps aux | grep 'hue' | awk '{print $2}'  | xargs kill -9


