#!/bin/bash

echo "Starting Liferay Portal Server"
/opt/liferay-portal-7.2.0-ga1/tomcat-9.0.17/bin/startup.sh

ps -ef | grep "liferay"