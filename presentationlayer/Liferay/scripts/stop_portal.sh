#!/bin/bash

######################### Stopping Liferay###################################
pkill -f liferay

ps -ef | pgrep -f "liferay" | xargs kill -9

sudo systemctl stop liferay

echo "Stopping Liferay Portal Server"
./opt/liferay-portal-7.2.0-ga1/tomcat-9.0.17/bin/shutdown.sh

ps -ef | grep "liferay"
