#!/bin/bash

sudo chmod -R 775 nifi-1.9.2-bin.zip
sudo unzip nifi-1.9.2-bin.zip
sudo chown -R dtpuser:hadoop nifi-1.9.2
sudo chmod -R 775 nifi-1.9.2


echo "Setting JAVA_HOME"
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc
echo "export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH"  >> ~/.bashrc
source ~/.bashrc

echo "Setting NIFI PROPERTIES"
sudo unzip nifi-1.9.2-bin.zip
cd nifi-1.9.2/
#Add the values to the following properties
#nifi.ui.banner.text=
#nifi.web.http.port=8080
#nifi.sensitive.props.key=

sudo sed -i "/nifi.ui.banner.text=/ s/=.*/=DataTachyonNifi/" conf/nifi.properties
sudo sed -i "/nifi.web.http.port=/ s/=.*/=9090/" conf/nifi.properties
sudo sed -i "/nifi.sensitive.props.key=/ s/=.*/=datatachyonnifi1234/" conf/nifi.properties
#sudo sed '/Java home/ i     JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' bin/nifi.sh
#sudo sed '/JAVA_HOME not set; results may vary/ i     JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' bin/nifi.sh

cd ..

sudo chown -R dtpuser:hadoop nifi-1.9.2
sudo chmod -R 775 nifi-1.9.2

#sudo echo "export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH"  >> /etc/environment

source ~/.bashrc
cat ~/.bashrc


whoami && hostname && pwd
ls -latr /opt/
ls -latr /opt/nifi-1.9.2
which java
#echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64"
#echo "JAVA_HOME: "$JAVA_HOME
#echo "PATH: "$PATH

echo "Installing Nifi"
sudo nifi-1.9.2/bin/nifi.sh install
nifi-1.9.2/bin/nifi.sh stop

#echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64"
#echo "JAVA_HOME: "$JAVA_HOME
#echo "PATH: "$PATH
ps -ef | grep nifi
echo "Starting Nifi"
nifi-1.9.2/bin/nifi.sh start
echo "Checking Status of Nifi"
nifi-1.9.2/bin/nifi.sh status
