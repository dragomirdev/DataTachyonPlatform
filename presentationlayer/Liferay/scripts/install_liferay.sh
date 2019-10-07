#!/bin/bash

#set -euxo pipefail

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk zip unzip net-tools software-properties-common
sudo apt -y autoremove

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

#Download Liferay https://sourceforge.net/projects/lportal/files/latest/download
#wget https://netix.dl.sourceforge.net/project/lportal/Liferay%20Portal/7.2.0%20GA1/liferay-ce-portal-tomcat-7.2.0-ga1-20190531153709761.tar.gz


sudo mv /home/dtpuser/liferay-ce-portal-tomcat-7.2.0-ga1-20190531153709761.tar.gz /opt/
cd /opt/
sudo tar -zxvf liferay-ce-portal-tomcat-7.2.0-ga1-20190531153709761.tar.gz
sudo chown -R dtpuser:hadoop liferay-portal-7.2.0-ga1/
sudo chmod -R 775 liferay-portal-7.2.0-ga1/
sudo rm liferay-ce-portal-tomcat-7.2.0-ga1-20190531153709761.tar.gz

#################################################### Adding Startup Services #################################################################
sudo mv /home/dtpuser/liferay.service /etc/systemd/system/
sudo chmod 755 /etc/systemd/system/liferay.service
sudo systemctl daemon-reload
sudo systemctl enable liferay
sudo systemctl start liferay

cd /opt/liferay-portal-7.2.0-ga1/

echo "Starting Liferay Server"
./tomcat-9.0.17/bin/startup.sh


