#!/bin/bash

cd /opt/liferay-portal-7.2.0-ga1/

echo "Starting Liferay Portal Server"
./tomcat-9.0.17/bin/startup.sh

ps -ef | grep "liferay"