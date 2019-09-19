#!/bin/bash

echo "Shutting Down Liferay Server"
./opt/liferay-portal-7.2.0-ga1//tomcat-9.0.17/bin/shutdown.sh

sudo rm -rf /opt/liferay-portal-7.2.0-ga1/

ls -latr  /home/dtpuser
ls -latr  /opt/
