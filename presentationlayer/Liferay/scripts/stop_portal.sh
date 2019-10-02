#!/bin/bash

######################### Stopping ELK###################################
pkill -f elasticsearch

ps -ef | pgrep -f "liferay" | xargs kill -9

sudo systemctl stop liferay

ps -ef | grep liferay

cd /opt/liferay-portal-7.2.0-ga1/

echo "Stopping Liferay Portal Server"
./tomcat-9.0.17/bin/stop.sh
