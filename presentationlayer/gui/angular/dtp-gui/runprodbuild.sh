#!/bin/bash
clear

echo "Building PROD DTP-GUI"
ng build --base-href=/dtp-gui/
echo "Copying PROD DIST to TOMCAT"
sudo mkdir -p /opt/tomcat9/webapps/dtp-gui
sudo chown -R hadoop:hadoop /opt/tomcat9/webapps
sudo chmod -R 775 /opt/tomcat9/webapps
cp -R dist/* /opt/tomcat9/webapps/dtp-gui/

